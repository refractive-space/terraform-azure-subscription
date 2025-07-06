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

# Note: To manage resources within the subscription after creation,
# configure a separate azurerm provider with the subscription_id

module "subscription" {
  source = "../.."

  # Note: display_name, subscription_name, and alias are optional
  # If not provided, they will be auto-generated using a UUID
  billing_scope_id = "/providers/Microsoft.Billing/billingAccounts/12345678-1234-1234-1234-123456789012:12345678-1234-1234-1234-123456789012_2019-05-31/billingProfiles/ABCD-EFGH-XXX-XXX"
  workload_type    = "DevTest"

  tags = {
    Environment = "Development"
    Team        = "Platform"
    Purpose     = "Testing"
  }
}