variable "resource_group_name" {
  type    = string
  default = "homelab-data-processing-rg"
}

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

variable "function_plan_name" {
  type    = string
  default = "dp-function-plan"
}

variable "function_app_name" {
  type    = string
  default = "dp-function-100"
}

variable "runtime_storage_account_name" {
  type    = string
  default = "dpruntimefunction100"
}

variable "runtime_storage_connection_string" {
  type      = string
  default   = ""
  sensitive = true
}

variable "data_storage_account_id" {
  type    = string
  default = ""
}

variable "data_storage_account_name" {
  type    = string
  default = "dataprocessingsa100"
}

variable "raw_container_name" {
  type    = string
  default = "raw-blob"
}

variable "processed_container_name" {
  type    = string
  default = "processed-blob"
}

variable "docint_endpoint" {
  type    = string
  default = ""
}

variable "docint_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "app_insights_connection_string" {
  type      = string
  default   = ""
  sensitive = true
}

variable "function_app_settings_base" {
  type    = map(string)
  default = {
    FUNCTIONS_WORKER_RUNTIME = "python"
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }
}
