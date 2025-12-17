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

variable "document_intelligence_name" {
  type    = string
  default = "dpintelligence100"
}
