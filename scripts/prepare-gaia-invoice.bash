#!/bin/bash
# NAME
#     prepare-gaia-invoice.bash - Create a PDF invoice from JSON data for Gaia
# 
# SYNOPSIS
#     prepare-gaia-invoice.bash invoice-data.json [invoice_dir]
#
# A simple wrapper around prepare-invoice.bash, prefilled with Gaia logo for
# convenience

PREPARE_INVOICE="/home/ej/Documents/projects/gaia/invoices-and-qr/src/prepare-invoice.bash"
GAIA_LOGO="/home/ej/Documents/projects/gaia/design/logo/logo-512.png"
${PREPARE_INVOICE} ${1} ${GAIA_LOGO} ${2}
