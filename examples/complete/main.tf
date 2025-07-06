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

  display_name        = "Production Subscription"
  subscription_name   = "production-sub"
  alias              = "production-alias"
  billing_scope_id   = "/providers/Microsoft.Billing/billingAccounts/12345678-1234-1234-1234-123456789012:12345678-1234-1234-1234-123456789012_2019-05-31/billingProfiles/ABCD-EFGH-XXX-XXX"
  management_group_id = "production-mg"
  workload_type      = "Production"

  # Management resource group
  create_management_resource_group      = true
  management_resource_group_name        = "production-management-rg"
  management_resource_group_location    = "East US"

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