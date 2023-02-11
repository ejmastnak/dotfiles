#!/usr/bin/env python
"""
NAME
    bq.py - Parse and run a YAML bean-query file
SYNOPSIS
    bq.py query.yaml [ledger.beancount]
DESCRIPTION
Parse and run a YAML bean-query file

Expects a query.yaml file with the following form:

    account: "Food AND Boo OR Too"
    date: "after today AND before -1m"
    tag: ""

"""
import sys, yaml, re, datetime, subprocess
import pandas as pd
from io import StringIO
from dateutil.relativedelta import relativedelta

DEFAULT_LEDGER = "/home/ej/Documents/basics/finances/accounting/ledger.beancount"
COLUMNS = ['account', 'payee', 'date', 'narration', 'number', 'currency']
AMOUNT_COL = COLUMNS.index('number')
CURRENCY_COL = COLUMNS.index('currency')

query = ""
ledger = ""

# E.g. ~30 for a query spanning 1 month or 7 for a query spanning 1 week
days_in_query_range = 0
process_date_avg_stats = True

def parse_dates(date_strings):
    """
    Input array of strings with the following possible values
        - "today"
        - "YYYY-MM-DD" (presumably with a legal month and day)
        - "-|+N{d|m|y}", e.g. -1d, +3m, etc. (relative to previous date)
    Output a corresponding array of strings of the format DATE(YYYY,MM,DD).

    """
    dates = []
    for i, d in enumerate(date_strings):
        if d == "today":
            dates.append(datetime.date.today())
            continue

        # Try matching to "-|+N{d|m|y}"
        pattern = re.compile("([+-])([0-9]+)([dmy])")
        m = pattern.match(d)
        if m is not None and i > 0:  # if match found
            amt = int(m.group(1) + m.group(2))  # produces e.g. +10, -42, etc.
            if m.group(3) == "d":
                delta = relativedelta(days=amt)
            if m.group(3) == "m":
                delta = relativedelta(months=amt)
            else: # i.e. if m.groups(3) == "y":
                delta = relativedelta(years=amt)
            dates.append(dates[i - 1] + delta)  # hence requirement of i > 0
            continue

        try:
            date = datetime.date.fromisoformat(d)
            dates.append(date)
            continue
        except ValueError:
            print("Error parsing date: {}. Using today's date instead.".format(d))
            dates.append(datetime.date.today())

    return ["DATE({},{},{})".format(date.year, date.month, date.day) for date in dates]

def parse_date(date_string, relto=None):
    """
    Input a string with one of the following possible values:
        - "YYYY-MM-DD" ISO 8601 date strings, e.g. "2022-10-22"
        - "today", interpreted as today's date
        - "[+-]\d+[dmy]", e.g. "+10d", "-1m", etc.
          In this case `relto` must be either "YYYY-MM-DD" or "today", and
          `date_string` is interpreted as relative to `relto`.
    Output a corresponding datetime.date object.

    Parameters
    ----------
    date_string : str
        As described above.
    relto : datetime.date
        A datetime.date object.

    """
    if date_string == "today":
        return datetime.date.today()

    # Try matching to "[+-]N[dmy]"
    pattern = re.compile("([+-])([0-9]+)([dmy])")
    m = pattern.match(date_string)
    if m is not None:  # if match found
        amt = int(m.group(1) + m.group(2))  # produces e.g. +10, -42, etc.
        if m.group(3) == "d":
            delta = relativedelta(days=amt)
        elif m.group(3) == "m":
            delta = relativedelta(months=amt)
        else: # i.e. if m.groups(3) == "y":
            delta = relativedelta(years=amt)
        return relto + delta

    try:
        date = datetime.date.fromisoformat(date_string)
        return date
    except ValueError:
        print("Error parsing date: {}. Returning today's date.".format(d))

    return datetime.date.today()

def get_bq_date(date):
    """
    Input a datetime.date object.
    Output a string of the form "DATE(YYYY,MM,DD)", which can be understood by
    bean-query.

    """
    return "DATE({},{},{})".format(date.year, date.month, date.day)

def construct_account_clause(account_clause):
    """
    Constructs account part of WHERE query.
    (Only called if `account_clause` is not None or empty.)

    """
    # E.g. "Foo AND Bar OR Baz" -> ["Foo", "AND", "Bar", "OR", "Baz"]
    account_clause = account_clause.split()
    global query

    for i, a in enumerate(account_clause):
        # 0, 2, 4, etc. are account names
        # 1, 3, etc., if present, are logical operators e.g. AND or OR
        if i % 2 == 0:
            query += " account ~ " + '"' + a + '"'  # surround account in quotes
        else:
            query += " " + a

def handle_date_interval(date_interval):
    """
    Processes a single date interval string of the form e.g. "(-2m, today)".
    Updates global bean-query string with the corresponding date clause.

    Matches `date_interval` to (a, b), where e.g. in "(-2m, today)",
    a = "-2m" and b = "today".
    Allowed values for `a` or `b`:
        - "YYYY-MM-DD" ISO 8601 date strings, e.g. "2022-10-22"
        - "today", interpretted as today's date
        - "0", allowed for `a` only and interpretted as "since the beginning of time".
        - "[+-]\d+[dmy]", e.g. "+10d", "-1m", etc.
          Relative dates are implicitly interpretted as relative to "today" if
          used in `a` and relative to `a` if used in `b`.
          Exception: if `a` is "0", relative dates in `b` are relative to "today".

    """
    global query, process_date_avg_stats, days_in_query_range

    # Word (\w, -, or +) followed by comma followed by zero or more white spaces
    # followed by word, all enclosed in parentheses.
    # E.g. in "(-2m, today)", a = "-2m" and b = "today"
    pattern = re.compile("\(([\w+\-]+),\s*([\w+\-]+)\)")
    m = pattern.match(date_interval)

    if m is not None:  # if match found
        a = m.group(1)
        b = m.group(2)
    else:
        print("Error parsing date interval: {}. Aborting.".format(date_interval))
        sys.exit()

    # Assume `a` and `b` have been successfully matched at this point.
    if a == "0":
        bdate = parse_date(b, relto=datetime.date.today())
        query += "(date <= {})".format(get_bq_date(bdate))

        # It doesn't make sense to compute averages over days, months, etc.
        # when no explicit date interval is specified
        process_date_avg_stats = False
    else:
        adate = parse_date(a, relto=datetime.date.today())
        bdate = parse_date(b, relto=adate)

        # Potentially swap dates such that a < b
        if bdate < adate:
            tmp = adate
            adate = bdate
            bdate = tmp

        days_in_query_range += (bdate - adate).days

        query += " (date >= {} AND date <= {})".format(get_bq_date(adate), get_bq_date(bdate))

def construct_date_clause(date_intervals):
    """
    Constructs date part of WHERE query.
    (Only called if `date_clause` is not None or empty.)
    Example inputs:
        - "(-2m, today)"
        - ["(-2m, today)", "(-1y, +1m)"]

    """
    global query
    # A single date interval string (i.e. not a list of strings)
    if type(date_intervals) is str:
        handle_date_interval(date_intervals)
    else:  # an array of date interval strings
        for i, date_interval in enumerate(date_intervals):
            handle_date_interval(date_interval)
            # Join multiple date intervals with OR operators
            if i != len(date_intervals) - 1:
                query += " OR"


def construct_tag_clause(tags):
    """
    Constructs tags part of WHERE query.
    (Only called if `tags` is not None or empty.)

    """
    # E.g. "#ljubljana-fmf AND #ljubljana-post-fmf" -> ["#ljubljana-fmf" "AND" "#ljubljana-post-fmf"]
    tags = tags.split()
    global query

    for i, t in enumerate(tags):
        # 0, 2, 4, etc. are tag names
        # 1, 3, etc., if present, are logical operators e.g. AND or OR
        if i % 2 == 0:
            query += " \"{}\" in tags".format(t)  # surround tag in quotes
        else:
            query += " " + t


def capture_query_result():
    """
    Runs bean-query.
    Captures the bean-query command's output.
    Checks for errors on stderr.
    Return result of the query as a StringIO than can be ready by Pandas.
    """
    result = subprocess.run(["bean-query", ledger, query],
                            capture_output=True,
                            text=True)
    if result.stderr:
        print("Error performing query: {}".format(result.stderr))
        print("Returning None.")
        return None
    else:
        if (result.stdout == "(empty)\n"):
            print("Query results are empty. Returning None.")
            return None

        print(result.stdout)
        return StringIO(result.stdout)

def describe_result_df(df):
    """
    Input results of a bean-query as a Pandas DataFrame.
    Analyzes and prints information about the query results.

    """
    # Detect distinct currencies in CURRENCY_COL
    currencies = df.iloc[:, CURRENCY_COL].unique()

    for cur in currencies:
        print(cur)
        print("---")
        mask = df.iloc[:, CURRENCY_COL] == cur
        amounts = df[mask].iloc[:, AMOUNT_COL].astype(float)
        sum = amounts.sum()

        print("Total: {:.2f} {}".format(sum, cur))

        if process_date_avg_stats:
            print("Average cost per...")
            print("  Day: {:.2f} {}".format(sum/days_in_query_range, cur))
            if days_in_query_range >= 7:
                print("  Week: {:.2f}, {}".format(7*sum/days_in_query_range, cur))
            if days_in_query_range >= 30:
                print("  30 days: {:.2f}, {}".format(30*sum/days_in_query_range, cur))

        print("")

if len(sys.argv) == 2:
    queryfile = sys.argv[1]
    ledger = DEFAULT_LEDGER
elif len(sys.argv) == 3:
    queryfile = sys.argv[1]
    ledger = sys.argv[2]
else:
    print("Error: incorrect number of command line arguments.")
    print("Usage: bq.py query.yaml [ledger.beancount]")
    sys.exit()

# Read query into a Python dict
with open(queryfile, "r") as stream:
    try:
        query_dict = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print("Error reading file.")
        print(exc)
        sys.exit()

account_clause = query_dict.get('account', None)
date_clause = query_dict.get('date', None)
tags = query_dict.get('tag', None)

# Columns to select
# -------------------------------------------------------------------- #
query += "select "
for i, col in enumerate(COLUMNS):
    query += col
    if i != len(COLUMNS) - 1:  # add comma to all but final column
        query += ", "
# -------------------------------------------------------------------- #

query += " where"

if account_clause is not None and account_clause != "":
    construct_account_clause(account_clause)

if date_clause is not None and date_clause != "":
    if account_clause is not None and account_clause != "":
        query += " AND"
    construct_date_clause(date_clause)

if tags is not None and tags != "": 
    if (account_clause is not None and account_clause != "") \
            or (date_clause is not None and date_clause != ""):
                query += " AND"
    construct_tag_clause(tags)

strio = capture_query_result()
if not strio:  # Abort on failed query or empty query results
    sys.exit()

# Drop zeroth row, which is only hyphens
df = pd.read_fwf(strio).drop([0])
describe_result_df(df)
