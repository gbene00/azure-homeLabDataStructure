## Azure Resource Group
variable "resource_group_name" {
  type    = string
  default = "homelab-data-processing-rg"
}

## Azure Location
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

## Azure Document Intelligence
variable "document_intelligence_name" {
  type    = string
  default = "dpintelligence100"
}
