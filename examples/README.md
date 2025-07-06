# Examples

This directory contains example configurations for the Azure Subscription Terraform module.

## Available Examples

- **[Basic](./basic)** - Simple subscription creation with minimal configuration
- **[Complete](./complete)** - Full-featured example demonstrating all module capabilities

## Usage

Each example directory contains:
- `main.tf` - Main Terraform configuration
- `outputs.tf` - Output definitions
- `README.md` - Example-specific documentation

To use an example:

1. Navigate to the example directory
2. Copy the configuration to your own directory
3. Modify the variables to match your environment
4. Run `terraform init`, `terraform plan`, and `terraform apply`

## Prerequisites

Before running any examples, ensure you have:

1. **Azure CLI** installed and authenticated
2. **Terraform** >= 1.8.0 installed
3. **Appropriate Azure permissions** for subscription creation
4. **Valid billing scope** with available credits or payment method
5. **Management group structure** (for examples using management groups)

## Provider Configuration

All examples require the Azure provider to be configured. Add this to your configuration:

```hcl
provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "subscription"
  subscription_id = module.subscription.subscription_id
  features {}
}
```

## Common Variables

Most examples use these common variables that you'll need to customize:

- `billing_scope_id` - Your Azure billing scope ID
- `management_group_id` - Your management group ID (if applicable)
- `tags` - Your organization's tagging strategy

## Getting Your Billing Scope ID

To find your billing scope ID, use the Azure CLI:

```bash
# List billing accounts
az billing account list --query "[].{Name:displayName, Id:id}" -o table

# Get billing profiles for an account
az billing profile list --account-name "YOUR_ACCOUNT_ID" --query "[].{Name:displayName, Id:id}" -o table
```

The billing scope ID format is:
```
/providers/Microsoft.Billing/billingAccounts/{accountId}/billingProfiles/{profileId}
```