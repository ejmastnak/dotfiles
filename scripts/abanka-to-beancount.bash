#!/bin/bash
# NAME
#     abanka-to-beancount - convert Abanka CSV report to beancount
# 
# SYNOPSIS
#     abanka-to-beancount abanka-report.csv

# Convert input to utf-8
iconv -f CP1250 -t UTF-8 -o "${1}.utf8.tmp" "${1}"
rm "${1}"
mv "${1}.utf8.tmp" "${1}"

output_file="${1%.csv}.beancount"
printf "" > "${output_file}"

# Abanka column             Bash varable
# ST. IZPISKA               _num                      # a small natural number
# POGODBA                   _contract                 # e.g. SIXXXXXXXXXXXXXXXXX
# RACUN                     _account                  # e.g. SIXXXXXXXXXXXXXXXXX
# DATUM KNJIZENJA           date_cleared_ddmmyyyy     # e.g. 08.11.2022
# DATUM VALUTE              date_transacted_ddmmyyyy  # e.g. 08.11.2022
# DOBRO                     amount_in                 # e.g. 42,00
# BREME                     amount_out                # e.g. 42,00
# VALUTA                    currency                  # e.g. EUR
# NAMEN                     description               # e.g. HOFER hvala
# SKLIC V DOBRO             id_in                     # e.g. SIYYYYYYYYYYYYYYY
# SKLIC V BREME             id_out                    # e.g. SI99
# UDELEZENEC - RACUN        payee_account             # e.g. SIXXXXXXXXXXXXXXXXX
# UDELEZENEC - NAZIV        payee_description         # generally a copy of `description`
# UDELEZENEC - BIC          payee_BIC                 # always empty so far
# KODA NAMENA               code                      # e.g. TAXS, STDY; a 4-letter code used for payment forms
# PRILIV V IZVORNI VALUTI   source_currency_inflow    # always blanks so far
# ODLIV V IZVORNI VALUTI    source_currency_outflow   # always blank so far
# IZVORNA VALUTA            source_currency           # always blank so far

# Switches decimal separator from `,` to `.`
# and thousands separator from `.` to ``
# Expects a single floating point number, e.g. 4.200,00
function swap_separators ()
{
  tmp="${1/./}"      # Remove thousands separator
  echo "${tmp/,/.}"  # Switch decimal separator
}

{
  # The extra braces and `read` skip the first line (header) of Abanka CSV;
  # see e.g. https://stackoverflow.com/a/31911198
  read
  while IFS=";" read -r \
     _num \
     _contract \
     _account \
     date_cleared_ddmmyyyy \
     date_transacted_ddmmyyyy \
     amount_in \
     amount_out \
     currency \
     description \
     _remainder
  do
    # Convert date from dd.mm.yyyy to yyyy-mm-dd
    echo "${date_transacted_ddmmyyyy}" | awk -F '.' '{ORS=""; print $3 "-" $2 "-" $1}' >> "${output_file}"

    # Log a transaction
    printf " txn" >> "${output_file}"

    # Log payee information; use xargs to trim trailing whitespace
    printf " \"$(echo "${description}" | xargs)\"" >> "${output_file}"

    # Leave description of transaction empty
    echo " \"TODO\"" >> "${output_file}"

    # If amount_in is blank, assume the transaction is an expense
    if [[ -z "${amount_in}" ]]; then
      echo "  Assets:Abanka:Checking -$(swap_separators ${amount_out}) ${currency}" >> "${output_file}"
      echo "  Expenses:TODO" >> "${output_file}"
    # If amount_in is not blank, assume transaction is income
    else
      echo "  TODO:Assets:Abanka:Checking +$(swap_separators ${amount_in}) ${currency}" >> "${output_file}"
      echo "  Income:TODO" >> "${output_file}"
    fi

    printf "\n" >> "${output_file}"

  done
} < "${1}"
