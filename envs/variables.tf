## Azure Region
variable "location" {
  type    = string
  default = "westeurope"
}

## Azure Resource Tags
variable "tags" {
  type = map(string)
  default = {
    project = "homelab-data-processing"
    env     = "home"
  }
}

## Azure Resource Group
variable "resource_group_name" {
  type    = string
  default = "homelab-data-processing-rg"
}

## Azure Storage Account for Data Processing
variable "data_storage_account_name" {
  type    = string
  default = "dataprocessingsa100"
}

## Azure Storage Account for Function App Runtime
variable "runtime_storage_account_name" {
  type    = string
  default = "dpruntimefunction100"
}

## Blob Container for Raw Data
variable "raw_container_name" {
  type    = string
  default = "raw-blob"
}

## Blob Container for Processed Data
variable "processed_container_name" {
  type    = string
  default = "processed-blob"
}

## Azure Function App
variable "function_app_name" {
  type    = string
  default = "dp-function-100"
}

## Azure Function App Service Plan
variable "function_plan_name" {
  type    = string
  default = "dp-function-plan"
}

## Azure Document Intelligence Service
variable "document_intelligence_name" {
  type    = string
  default = "dpintelligence100"
}

## Azure Static Web App
variable "static_web_app_name" {
  type    = string
  default = "dp-static-app"
}

## Azure Log Analytics Workspace
variable "log_analytics_name" {
  type    = string
  default = "dp-law"
}

## Azure Log Analytics Workspace Retention Days
variable "log_analytics_retention_days" {
  type    = number
  default = 30
}

## Azure Application Insights
variable "app_insights_name" {
  type    = string
  default = "dp-insights"
}

## Blob Storage Settings
variable "enable_blob_versioning" {
  type    = bool
  default = true
}

## Blob Storage Soft Delete Retention Days
variable "soft_delete_retention_days" {
  type    = number
  default = 14
}
## Existing Azure Key Vault ID
variable "existing_key_vault_id" {
  type    = string
  default = "/subscriptions/da045766-61df-4298-9cac-effd16671de9/resourceGroups/homelab-rg/providers/Microsoft.KeyVault/vaults/gbenehomelab-kv"
}
