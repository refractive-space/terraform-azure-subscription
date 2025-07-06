# Terraform version and provider requirements
terraform {
  required_version = ">= 1.8.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
      configuration_aliases = [azurerm.subscription]
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }
}