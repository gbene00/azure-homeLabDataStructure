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
