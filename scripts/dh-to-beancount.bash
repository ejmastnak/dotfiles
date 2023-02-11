#!/bin/bash
# NAME
#     dh-to-beancount - convert DH CSV report to beancount
# 
# SYNOPSIS
#     dh-to-beancount dh-report.csv

# Convert input to utf-8
iconv -f CP1250 -t UTF-8 -o "${1}.utf8.tmp" "${1}"
rm "${1}"
mv "${1}.utf8.tmp" "${1}"

# Lines to skip in header of downloaded CSV
dh_header_lines=10
output_file="${1%.csv}.beancount"

printf "" > "${output_file}"

# DH column              Bash varable               Example
# ---------              ------------               -------
# Valuta                 currency                   e.g. EUR
# Datum valute           date_transacted_ddmmyyyy   e.g. 08.11.2022
# Datum knjizenja        date_cleared_ddmmyyyy      e.g. 08.11.2022
# ID transakcije         id                         e.g. 178892861
# St. za reklamacijo     refund_id                  e.g. 860000178892861
# Prejemnik / Plaènik    payee                      e.g. DELAVSKA HRANILNICA d.d. LJUBLJANA SI56610006100000062
# Breme                  amount_out                 e.g. 42,00|null
# Dobro                  amount_in                  e.g. 42,00|null
# Referenca placnika     payer_reference            e.g. SI99
# Referenca prejemnika   payee_reference            e.g. SI120922365981552
# Opis prejemnika        description          e.g. Plačilo računa 22290120236

# Switches decimal separator from `,` to `.`
# and thousands separator from `.` to ``
# Expects a single floating point number, e.g. 4.200,00
function swap_separators ()
{
  tmp="${1/./}"      # Remove thousands separator
  echo "${tmp/,/.}"  # Switch decimal separator
}

{
  # The extra braces and `read` statements skip the first 10 lines (header) of DH CSV;
  # see e.g. https://stackoverflow.com/a/31911198
  for i in $(seq $dh_header_lines); do
    read
  done

  while IFS=";" read -r \
    currency \
    date_cleared_ddmmyyyy \
    date_transacted_ddmmyyyy \
    id \
    refund_id \
    payee\
    amount_out \
    amount_in \
    payer_reference \
    payee_reference \
    description
    do
      # Convert date from dd.mm.yyyy to yyyy-mm-dd
      echo "${date_transacted_ddmmyyyy}" | awk -F '.' '{ORS=""; print $3 "-" $2 "-" $1}' >> "${output_file}"

    # Log a transaction
    printf " txn" >> "${output_file}"

    # Log payee information; use xargs to trim trailing whitespace
    printf " \"$(echo "${payee}" | xargs)\"" >> "${output_file}"

    # Leave description of transaction empty
    echo " \"${description}\"" >> "${output_file}"

    # If amount_in is blank, assume the transaction is an expense
    if [[ -z "${amount_in}" ]]; then
      echo "  Assets:DH:Checking -$(swap_separators ${amount_out}) ${currency}" >> "${output_file}"
      echo "  Expenses:TODO" >> "${output_file}"
      # If amount_in is not blank, assume transaction is income
    else
      echo "  Assets:DH:Checking +$(swap_separators ${amount_in}) ${currency}" >> "${output_file}"
      echo "  Income:TODO" >> "${output_file}"
    fi

    printf "\n" >> "${output_file}"

  done
} < "${1}"
