## Azure Resource Group
variable "resource_group_name" {
  type    = string
  default = "homelab-data-processing-rg"
}

## Azure LocationA
variable "location" {
  type    = string
  default = "westeurope"
}

## Azure Tags
variable "tags" {
  type = map(string)
  default = {
    project = "homelab-data-processing"
    env     = "home"
  }
}

## Azure Function App Plan
variable "function_plan_name" {
  type    = string
  default = "dp-function-plan"
}

## Azure Function App
variable "function_app_name" {
  type    = string
  default = "dp-function-100"
}

## Azure Storage Account for Function App Runtime
variable "runtime_storage_account_name" {
  type    = string
  default = "dpruntimefunction100"
}

## Azure Storage Account for Function App Runtime - Connection String
variable "runtime_storage_connection_string" {
  type      = string
  default   = ""
  sensitive = true
}

## Azure Data Storage Account ID for Function App access
variable "data_storage_account_id" {
  type    = string
  default = ""
}

## Azure Data Storage Account Name for Function App access
variable "data_storage_account_name" {
  type    = string
  default = "dataprocessingsa100"
}

## Blob Container for raw data
variable "raw_container_name" {
  type    = string
  default = "raw-blob"
}

## Blob Container for processed data
variable "processed_container_name" {
  type    = string
  default = "processed-blob"
}

## Azure Document Intelligence Service Endpoint
variable "docint_endpoint" {
  type    = string
  default = ""
}

## Azure Document Intelligence Service Key
variable "docint_key" {
  type      = string
  default   = ""
  sensitive = true
}

## Azure Insights Connection String
variable "app_insights_connection_string" {
  type      = string
  default   = ""
  sensitive = true
}

## Azure Function App Base Settings
variable "function_app_settings_base" {
  type    = map(string)
  default = {
    FUNCTIONS_WORKER_RUNTIME = "python"
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }
}

## Azure Data Storage Account Connection String for Function App
variable "data_storage_connection_string" {
  type      = string
  default   = ""
  sensitive = true
}

## Azure Function App CORSS
variable "function_cors_allowed_origins" {
  type    = list(string)
  default = [
    "http://localhost:8080"
  ]
}
