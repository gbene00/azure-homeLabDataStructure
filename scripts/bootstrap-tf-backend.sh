#!/usr/bin/env bash
# bootstrap-tf-backend.sh

# Purpose:
# - Creates the Azure resources needed for Terraform remote state (azurerm backend):
#   1) Resource Group
#   2) Storage Account
#   3) Blob Container

# set -euo pipefail
# LOCATION="westeurope"
# RG="terraform-rg"
# SA="terraformstatesa1"
# CONTAINER="terraform-state"

# 1) Create Resource Group
# az group create -n "$RG" -l "$LOCATION"

# 2) Create Storage Account (Standard LRS)
# az storage account create \
#   -n "$SA" \
#   -g "$RG" \
#   -l "$LOCATION" \
#   --sku Standard_LRS

# 3) Create Blob Container for Terraform state
# az storage container create \
#   --name "$CONTAINER" \
#   --account-name "$ST"

# echo "Terraform backend resources created:"
# echo "RG=$RG"
# echo "StorageAccount=$ST"
# echo "Container=$CONTAINER"
