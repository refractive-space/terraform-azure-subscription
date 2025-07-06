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

  display_name        = "Production Subscription"
  subscription_name   = "production-sub"
  alias              = "production-alias"
  billing_scope_id   = "/providers/Microsoft.Billing/billingAccounts/12345678-1234-1234-1234-123456789012:12345678-1234-1234-1234-123456789012_2019-05-31/billingProfiles/ABCD-EFGH-XXX-XXX"
  management_group_id = "production-mg"
  workload_type      = "Production"

  # Note: Resource group creation moved to separate configuration

  # Budget configuration
  create_budget     = true
  budget_name       = "production-budget"
  budget_amount     = 5000
  budget_time_grain = "Monthly"
  budget_start_date = "2024-01-01"
  budget_end_date   = "2024-12-31"

  budget_notifications = [
    {
      enabled        = true
      threshold      = 70
      operator       = "GreaterThan"
      threshold_type = "Actual"
      contact_emails = ["admin@example.com"]
      contact_groups = []
      contact_roles  = ["Owner"]
    },
    {
      enabled        = true
      threshold      = 85
      operator       = "GreaterThan"
      threshold_type = "Actual"
      contact_emails = ["admin@example.com", "finance@example.com"]
      contact_groups = []
      contact_roles  = ["Owner", "Contributor"]
    },
    {
      enabled        = true
      threshold      = 100
      operator       = "GreaterThan"
      threshold_type = "Forecasted"
      contact_emails = ["finance@example.com"]
      contact_groups = []
      contact_roles  = ["Owner"]
    }
  ]

  tags = {
    Environment    = "Production"
    BusinessUnit   = "Engineering"
    CostCenter     = "123456"
    ManagedBy      = "Terraform"
    Owner          = "platform-team@example.com"
    Project        = "Core Infrastructure"
    DataClass      = "Internal"
  }
}