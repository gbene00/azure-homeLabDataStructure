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

variable "enable_blob_versioning" {
  type    = bool
  default = true
}

variable "soft_delete_retention_days" {
  type    = number
  default = 14
}
