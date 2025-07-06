terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "subscription"
  subscription_id = module.subscription.subscription_id
  features {}
}

module "subscription" {
  source = "../.."

  display_name     = "Development Subscription"
  billing_scope_id = "/providers/Microsoft.Billing/billingAccounts/12345678-1234-1234-1234-123456789012:12345678-1234-1234-1234-123456789012_2019-05-31/billingProfiles/ABCD-EFGH-XXX-XXX"
  workload_type    = "DevTest"

  tags = {
    Environment = "Development"
    Team        = "Platform"
    Purpose     = "Testing"
  }
}