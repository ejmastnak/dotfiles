#!/bin/bash
# NAME
#     beancount-from-vanguard.bash - convert Vanguard CSV report to Beancount
# 
# SYNOPSIS
#     beancount-from-vanguard.bash vanguard-report.csv

# Lines to skip in header of downloaded CSV
header_lines=1
output_file="${1%.csv}.beancount"
VMFXX="Assets:Vanguard:MoneyMarket"

printf "" > "${output_file}"


# Vanguard column           Example
# ---------------           -------
# Account Number            12345678
# Trade Date                2023-02-07
# Settlement Date           2023-02-07
# Transaction Type          Sweep out
# Transaction Description   VANGUARD FEDERAL MONEY MARKET FUND
# Investment Name           VANGUARD FEDERAL MONEY MARKET FUND Settlement Fund
# Symbol                    VGT (often empty)
# Shares                    42
# Share Price               100.00
# Principal Amount          4200.00
# Commissions and Fees      10.00
# Net Amount                4190.00
# Accrued Interest          0.00
# Account Type              Cash

{
  # The extra braces and `read` statements skip the CSV header lines
  # see e.g. https://stackoverflow.com/a/31911198
  for i in $(seq $header_lines); do
    read
  done

  while IFS="," read -r \
    account_number \
    trade_date \
    settlement_date \
    transaction_type \
    transaction_description \
    investment_name \
    symbol \
    shares \
    share_price \
    principal_amount \
    commissions_and_fees \
    net_amount \
    accrued_interest \
    account_type \
    remainder
    do

      # Skip Sweep in and Sweep out transaction_type
      if [[ ${account_number} == "" || ${transaction_type} == "Sweep out" || ${transaction_type} == "Sweep in" || ${transaction_type} == "Reinvestment" ]]; then
        continue
      fi

      printf "${settlement_date}" >> "${output_file}"

      # Log a transaction
      printf " txn" >> "${output_file}"

      # Vanguard is always payee
      printf " \"Vanguard\"" >> "${output_file}"

      # Transaction description
      echo " \"${transaction_type} ${transaction_description}\"" >> "${output_file}"

      # Withdrawal
      if [[ ${transaction_type} == "Withdrawal" ]]; then
        echo "  ${VMFXX} ${net_amount} USD" >> "${output_file}"
        echo "  Assets:SchoolsFirst:Checking" >> "${output_file}"
        echo "  ; TODO: confirm SchoolsFirst" >> "${output_file}"

      # Funds Received
    elif [[ ${transaction_type} == "Funds Received" ]]; then
      echo "  ${VMFXX} +${net_amount} USD" >> "${output_file}"
      echo "  Assets:SchoolsFirst:Checking" >> "${output_file}"
      echo "  ; TODO: confirm SchoolsFirst" >> "${output_file}"

      # Dividends
    elif [[ ${transaction_type} == "Dividend" ]]; then
      echo "  ${VMFXX} +${net_amount} USD" >> "${output_file}"
      echo "  Income:USD:Vanguard:Dividends:TODO" >> "${output_file}"

      # Interest
    elif [[ ${transaction_type} == "Interest" ]]; then
      echo "  ${VMFXX} +${net_amount} USD" >> "${output_file}"
      echo "  Income:USD:Vanguard:Interest" >> "${output_file}"

      # Corp Action (Redemption)
    elif [[ ${transaction_type} == "Corp Action (Redemption)" ]]; then
      echo "  ${VMFXX} +${net_amount} USD" >> "${output_file}"
      echo "  TODO:Vanguard:CorpActionRedemption" >> "${output_file}"

      # Sell
    elif [[ ${transaction_type} == "Sell" ]]; then
      echo "  ${VMFXX} +${net_amount} USD" >> "${output_file}"
      echo "  Assets:Vanguard:TODO" >> "${output_file}"
      echo "  Expenses:USD:Financial:VanguardCommission" >> "${output_file}"
      echo "  ; TODO: note to self for later to check potential commission when you have an actual record on file" >> "${output_file}"

      # Buy
    elif [[ ${transaction_type} == "Buy" ]]; then
      echo "  Assets:Vanguard:TODO" >> "${output_file}"
      echo "  ${VMFXX} ${net_amount} USD" >> "${output_file}"

    else
      echo "  ; ERROR: unrecognized transaction type: ${transaction_type}" >> "${output_file}"
      fi

      printf "\n" >> "${output_file}"

    done
  } < "${1}"
