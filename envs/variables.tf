variable "location" {
  type    = string
  default = "westeurope"
}

variable "tags" {
  type = map(string)
  default = {
    project = "homelab-data-processing"
    env     = "home"
  }
}

variable "resource_group_name" {
  type    = string
  default = "homelab-data-processing-rg"
}

variable "data_storage_account_name" {
  type    = string
  default = "dataprocessingsa100"
}

variable "runtime_storage_account_name" {
  type    = string
  default = "dpruntimefunction100"
}

variable "raw_container_name" {
  type    = string
  default = "raw-blob"
}

variable "processed_container_name" {
  type    = string
  default = "processed-blob"
}

variable "function_app_name" {
  type    = string
  default = "dp-function-100"
}

variable "function_plan_name" {
  type    = string
  default = "dp-function-plan"
}

variable "document_intelligence_name" {
  type    = string
  default = "dpintelligence100"
}

variable "static_web_app_name" {
  type    = string
  default = "dp-static-app"
}

variable "log_analytics_name" {
  type    = string
  default = "dp-law"
}

variable "log_analytics_retention_days" {
  type    = number
  default = 30
}

variable "app_insights_name" {
  type    = string
  default = "dp-insights"
}

variable "enable_blob_versioning" {
  type    = bool
  default = true
}

variable "soft_delete_retention_days" {
  type    = number
  default = 14
}

variable "existing_key_vault_id" {
  type    = string
  default = "/subscriptions/da045766-61df-4298-9cac-effd16671de9/resourceGroups/homelab-rg/providers/Microsoft.KeyVault/vaults/gbenehomelab-kv"
}
