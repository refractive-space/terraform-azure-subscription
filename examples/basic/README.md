# Basic Example

This example demonstrates the simplest possible configuration for creating an Azure subscription using this module.

## What This Example Creates

- Azure subscription with DevTest workload type
- Basic tagging for environment identification
- No management group association
- No budget or cost management features
- No management resource group

## Configuration

```hcl
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
```

## Prerequisites

Before running this example, you need:

1. **Azure CLI** authenticated to your tenant
2. **Terraform** >= 1.8.0 installed
3. **Billing scope permissions** to create subscriptions
4. **Valid billing scope ID** (replace the example ID with your actual billing scope)

## Getting Your Billing Scope ID

To find your billing scope ID:

```bash
# List billing accounts
az billing account list --query "[].{Name:displayName, Id:id}" -o table

# Get billing profiles for an account
az billing profile list --account-name "YOUR_ACCOUNT_ID" --query "[].{Name:displayName, Id:id}" -o table
```

## Usage

1. **Update the billing scope ID** in `main.tf` with your actual billing scope ID
2. **Customize the tags** to match your organization's tagging strategy
3. **Initialize and apply**:

```bash
terraform init
terraform plan
terraform apply
```

## Outputs

This example outputs:
- `subscription_id` - The ID of the created subscription
- `subscription_name` - The name of the created subscription
- `tenant_id` - The tenant ID of the subscription

## Next Steps

After creating the subscription, you might want to:
1. Associate it with a management group
2. Set up budgets and cost alerts
3. Create resource groups for workloads
4. Apply Azure policies and RBAC

See the [complete example](../complete) for a more comprehensive configuration.