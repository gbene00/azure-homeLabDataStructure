### Azure Resource Group
variable "resource_group_name" {
  type    = string
  default = "homelab-data-processing-rg"
}

### Azure Location
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

## Azure Data Storage Account
variable "data_storage_account_name" {
  type    = string
  default = "dataprocessingsa100"
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

## Enable Blob Versioning
variable "enable_blob_versioning" {
  type    = bool
  default = true
}

## Soft Delete Retention Days
variable "soft_delete_retention_days" {
  type    = number
  default = 14
}

## Blob CORS Allowed Origins
variable "blob_cors_allowed_origins" {
  type    = list(string)
  default = [
    "http://localhost:8080",
    "https://mango-beach-0dfbb7703.3.azurestaticapps.net"
  ]
}
