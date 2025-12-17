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

## Azure Static Web App
variable "static_web_app_name" {
  type    = string
  default = "dp-static-app"
}
