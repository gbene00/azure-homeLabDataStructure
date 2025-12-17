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

## Azure Log Analytics Workspace
variable "log_analytics_name" {
  type    = string
  default = "dp-law"
}

## Azure Log Analytics Retention Days
variable "log_analytics_retention_days" {
  type    = number
  default = 30
}

## Azure Application Insights
variable "app_insights_name" {
  type    = string
  default = "dp-insights"
}
