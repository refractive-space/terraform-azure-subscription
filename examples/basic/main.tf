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

  # Use billing components instead of direct billing_scope_id
  billing_account_name = "d0af5c57-9e26-51a3-83dd-7016c847c58d:a511b608-e4a4-4ab1-96b7-430b05b7d1a2_2019-05-31"
  billing_profile_name = "WJSQ-JV2N-BG7-PGB"
  invoice_section_name = "S3TC-J744-PJA-PGB"

  workload_type = "DevTest"

  tags = {
    Environment = "Development"
    Team        = "Platform"
    Purpose     = "Testing"
  }
}