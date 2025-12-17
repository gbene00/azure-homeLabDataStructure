terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.54.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "terraformstatesa1"
    container_name       = "terraform-state"
    key                  = "homelab-data-transformation.tfstate"
  }
}

provider "azurerm" {
  features {}

  # For CI/CD with GitHub OIDC, there is no need to specify subscription_id here
  subscription_id = "da045766-61df-4298-9cac-effd16671de9"
}