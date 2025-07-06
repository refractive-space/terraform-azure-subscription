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
  # Use billing components instead of direct billing_scope_id
  billing_account_name = "d0af5c57-9e26-51a3-83dd-7016c847c58d:a511b608-e4a4-4ab1-96b7-430b05b7d1a2_2019-05-31"
  billing_profile_name = "WJSQ-JV2N-BG7-PGB"
  invoice_section_name = "S3TC-J744-PJA-PGB"
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