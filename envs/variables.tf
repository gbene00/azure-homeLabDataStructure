## Azure Region
variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

## Azure Tags
variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
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

## Azure Storage Account for raw and processed data
variable "data_storage_account_name" {
  description = "Storage account for raw/processed data"
  type        = string
  default     = "dataprocessingsa100"
}

## Azure Storage Account for Functions runtime
variable "runtime_storage_account_name" {
  description = "Storage account used by Functions runtime (AzureWebJobsStorage)"
  type        = string
  default     = "dpruntimefunction100"
}

## Azure Blob Containers
variable "raw_container_name" {
  type    = string
  default = "raw-blob"
}

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

## Azure Cognitive Services - Document Intelligence
variable "document_intelligence_name" {
  type    = string
  default = "dpintelligence100"
}

## Azure Static Web App
variable "static_web_app_name" {
  type    = string
  default = "dp-static-app"
}

## Azure Log Analytics
variable "log_analytics_name" {
  type    = string
  default = "dp-law"
}

## Azure Application Insights
variable "app_insights_name" {
  type    = string
  default = "dp-insights"
}

## Blob Storage Versioning
variable "enable_blob_versioning" {
  type    = bool
  default = true
}
## Blob Storage Soft Delete Retention
variable "soft_delete_retention_days" {
  type    = number
  default = 14
}

## Existing Key Vault ID
variable "existing_key_vault_id" {
  description = "Existing Key Vault resource ID (optional)."
  type        = string
  default     = "/subscriptions/da045766-61df-4298-9cac-effd16671de9/resourceGroups/homelab-rg/providers/Microsoft.KeyVault/vaults/gbenehomelab-kv"
}
