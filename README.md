# Azure Subscription Terraform Module

[![Terraform Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/your-org/subscription/azure)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Terraform Version](https://img.shields.io/badge/terraform-%3E%3D1.8.0-blue.svg)](https://www.terraform.io/)
[![Azure Provider](https://img.shields.io/badge/azurerm-%3E%3D3.0-blue.svg)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

A comprehensive Terraform module for creating and managing Azure subscriptions with management group association, resource groups, and cost management features.

## Features

- ✅ **Subscription Creation** - Create Azure subscriptions with comprehensive configuration
- ✅ **Automatic Naming** - Generate unique names using UUID when not provided
- ✅ **Management Group Integration** - Associate subscriptions with management groups
- ✅ **Cost Management** - Set up budgets and cost alerts
- ✅ **Workload Classification** - Support for Production and DevTest workloads
- ✅ **Input Validation** - Built-in validation for all inputs
- ✅ **Flexible Configuration** - Optional components for different use cases
- ✅ **UUID Generation** - Consistent UUID-based naming for subscription identifiers
- ✅ **Comprehensive Outputs** - Access all subscription details and metadata

## Usage

### Basic Example

```hcl
module "development_subscription" {
  source = "your-org/subscription/azure"

  display_name      = "Development Subscription"
  billing_scope_id  = "/providers/Microsoft.Billing/billingAccounts/12345678-1234-1234-1234-123456789012:12345678-1234-1234-1234-123456789012_2019-05-31/billingProfiles/ABCD-EFGH-XXX-XXX"
  workload_type     = "DevTest"

  tags = {
    Environment = "Development"
    Team        = "Platform"
  }
}
```

### Auto-Generated Naming Example

```hcl
module "auto_subscription" {
  source = "your-org/subscription/azure"

  # All naming fields are optional - UUID will be generated automatically
  # display_name, subscription_name, and alias will use the same UUID
  billing_scope_id = "/providers/Microsoft.Billing/billingAccounts/12345678-1234-1234-1234-123456789012:12345678-1234-1234-1234-123456789012_2019-05-31/billingProfiles/ABCD-EFGH-XXX-XXX"
  workload_type    = "DevTest"

  tags = {
    Environment = "Testing"
    Purpose     = "Auto-Generated"
  }
}
```

### With Management Group Association

```hcl
module "production_subscription" {
  source = "your-org/subscription/azure"
  
  display_name        = "Production Subscription"
  billing_scope_id    = "/providers/Microsoft.Billing/billingAccounts/12345678-1234-1234-1234-123456789012:12345678-1234-1234-1234-123456789012_2019-05-31/billingProfiles/ABCD-EFGH-XXX-XXX"
  management_group_id = "production-mg"
  workload_type       = "Production"
  
  tags = {
    Environment = "Production"
    Team        = "Engineering"
    CostCenter  = "123456"
  }
}
```

### With Budget and Cost Management

```hcl
module "sandbox_subscription" {
  source = "your-org/subscription/azure"
  
  display_name     = "Sandbox Subscription"
  billing_scope_id = "/providers/Microsoft.Billing/billingAccounts/12345678-1234-1234-1234-123456789012:12345678-1234-1234-1234-123456789012_2019-05-31/billingProfiles/ABCD-EFGH-XXX-XXX"
  workload_type    = "DevTest"
  
  # Budget configuration
  create_budget    = true
  budget_amount    = 500
  budget_time_grain = "Monthly"
  budget_start_date = "2024-01-01"
  
  budget_notifications = [
    {
      enabled        = true
      threshold      = 80
      operator       = "GreaterThan"
      threshold_type = "Actual"
      contact_emails = ["admin@example.com"]
      contact_groups = []
      contact_roles  = ["Owner"]
    },
    {
      enabled        = true
      threshold      = 100
      operator       = "GreaterThan"
      threshold_type = "Forecasted"
      contact_emails = ["finance@example.com"]
      contact_groups = []
      contact_roles  = ["Contributor"]
    }
  ]
  
  tags = {
    Environment = "Sandbox"
    Purpose     = "Testing"
  }
}
```

### Complete Example

```hcl
module "compliance_subscription" {
  source = "your-org/subscription/azure"
  
  display_name        = "Compliance Subscription"
  subscription_name   = "compliance-sub"
  alias              = "compliance-alias"
  billing_scope_id   = "/providers/Microsoft.Billing/billingAccounts/12345678-1234-1234-1234-123456789012:12345678-1234-1234-1234-123456789012_2019-05-31/billingProfiles/ABCD-EFGH-XXX-XXX"
  management_group_id = "compliance-mg"
  workload_type      = "Production"
  
  # Management resource group
  create_management_resource_group      = true
  management_resource_group_name        = "compliance-management-rg"
  management_resource_group_location    = "East US"
  
  # Budget configuration
  create_budget     = true
  budget_name       = "compliance-budget"
  budget_amount     = 2000
  budget_time_grain = "Monthly"
  budget_start_date = "2024-01-01"
  budget_end_date   = "2024-12-31"
  
  budget_notifications = [
    {
      enabled        = true
      threshold      = 75
      operator       = "GreaterThan"
      threshold_type = "Actual"
      contact_emails = ["compliance@example.com"]
      contact_groups = []
      contact_roles  = ["Owner"]
    }
  ]
  
  tags = {
    Environment    = "Compliance"
    BusinessUnit   = "Legal"
    DataClass      = "Confidential"
    ManagedBy      = "Terraform"
    Owner          = "compliance-team@example.com"
  }
}
```

## Examples

See the [examples](./examples) directory for more comprehensive usage patterns:

- [Basic](./examples/basic) - Simple subscription creation
- [Complete](./examples/complete) - Full-featured example with all options

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription) | resource |
| [azurerm_management_group_subscription_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association) | resource |
| [azurerm_resource_group.management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_consumption_budget_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the Azure subscription to create | `string` | n/a | yes |
| <a name="input_billing_scope_id"></a> [billing\_scope\_id](#input\_billing\_scope\_id) | The billing scope ID for the Azure subscription | `string` | n/a | yes |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | The name of the Azure subscription. If empty, will use display_name | `string` | `""` | no |
| <a name="input_alias"></a> [alias](#input\_alias) | The alias for the Azure subscription (for programmatic access) | `string` | `""` | no |
| <a name="input_workload_type"></a> [workload\_type](#input\_workload\_type) | The workload type for the Azure subscription | `string` | `"Production"` | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The management group ID to associate the subscription with. If empty, subscription will remain in tenant root | `string` | `""` | no |
| <a name="input_create_management_resource_group"></a> [create\_management\_resource\_group](#input\_create\_management\_resource\_group) | Whether to create a management resource group in the subscription | `bool` | `true` | no |
| <a name="input_management_resource_group_name"></a> [management\_resource\_group\_name](#input\_management\_resource\_group\_name) | The name of the management resource group. If empty, will be auto-generated | `string` | `""` | no |
| <a name="input_management_resource_group_location"></a> [management\_resource\_group\_location](#input\_management\_resource\_group\_location) | The Azure region for the management resource group | `string` | `"East US"` | no |
| <a name="input_create_budget"></a> [create\_budget](#input\_create\_budget) | Whether to create a budget for the subscription | `bool` | `false` | no |
| <a name="input_budget_name"></a> [budget\_name](#input\_budget\_name) | The name of the budget. If empty, will be auto-generated | `string` | `""` | no |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | The budget amount for the subscription | `number` | `1000` | no |
| <a name="input_budget_time_grain"></a> [budget\_time\_grain](#input\_budget\_time\_grain) | The time grain for the budget (Monthly, Quarterly, Annually) | `string` | `"Monthly"` | no |
| <a name="input_budget_start_date"></a> [budget\_start\_date](#input\_budget\_start\_date) | The start date for the budget (YYYY-MM-DD format) | `string` | `""` | no |
| <a name="input_budget_end_date"></a> [budget\_end\_date](#input\_budget\_end\_date) | The end date for the budget (YYYY-MM-DD format). If empty, budget will not expire | `string` | `""` | no |
| <a name="input_budget_notifications"></a> [budget\_notifications](#input\_budget\_notifications) | List of budget notifications to configure | <pre>list(object({<br>    enabled        = bool<br>    threshold      = number<br>    operator       = string<br>    threshold_type = string<br>    contact_emails = list(string)<br>    contact_groups = list(string)<br>    contact_roles  = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | The ID of the Azure subscription |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID of the Azure subscription |
| <a name="output_subscription_name"></a> [subscription\_name](#output\_subscription\_name) | The name of the Azure subscription |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the Azure subscription |
| <a name="output_workload_type"></a> [workload\_type](#output\_workload\_type) | The workload type of the Azure subscription |
| <a name="output_management_group_association_id"></a> [management\_group\_association\_id](#output\_management\_group\_association\_id) | The ID of the management group association, if created |
| <a name="output_management_resource_group_id"></a> [management\_resource\_group\_id](#output\_management\_resource\_group\_id) | The ID of the management resource group, if created |
| <a name="output_management_resource_group_name"></a> [management\_resource\_group\_name](#output\_management\_resource\_group\_name) | The name of the management resource group, if created |
| <a name="output_management_resource_group_location"></a> [management\_resource\_group\_location](#output\_management\_resource\_group\_location) | The location of the management resource group, if created |
| <a name="output_budget_id"></a> [budget\_id](#output\_budget\_id) | The ID of the subscription budget, if created |
| <a name="output_budget_name"></a> [budget\_name](#output\_budget\_name) | The name of the subscription budget, if created |
| <a name="output_budget_amount"></a> [budget\_amount](#output\_budget\_amount) | The amount of the subscription budget, if created |

## Prerequisites

Before using this module, ensure you have:

1. **Azure subscription creation permissions** in your tenant:
   - `Microsoft.Subscription/subscriptions/write`
   - `Microsoft.Management/managementGroups/subscriptions/write`
   - `Microsoft.Resources/subscriptions/resourceGroups/write`
   - `Microsoft.Consumption/budgets/write`
2. **Valid billing scope** with available credits or payment method
3. **Management group structure** (if using management group association)
4. **Appropriate Azure Provider configuration** with subscription alias support

## Input Validation

This module includes comprehensive input validation:

- **Display Name**: Must be 1-64 characters
- **Subscription Name**: Must be 1-64 characters or empty string
- **Alias**: Must contain only alphanumeric characters, hyphens, and underscores
- **Billing Scope ID**: Must be a valid Azure billing scope resource ID
- **Workload Type**: Must be either "Production" or "DevTest"
- **Management Group ID**: Must be valid management group ID or resource ID
- **Budget Amount**: Must be greater than 0
- **Budget Time Grain**: Must be Monthly, Quarterly, or Annually
- **Budget Dates**: Must be in YYYY-MM-DD format
- **Budget Notifications**: Comprehensive validation for all notification properties

## Subscription Lifecycle Management

This module implements several Azure subscription management features:

### Workload Classification
- **Production**: Standard pricing and features
- **DevTest**: Reduced pricing for development and testing workloads

### Management Group Association
Automatically associates subscriptions with management groups for:
- Policy inheritance
- RBAC inheritance
- Cost management hierarchy
- Governance structure

### Cost Management
- **Budgets**: Set spending limits with configurable time periods
- **Alerts**: Email and role-based notifications
- **Forecasting**: Proactive cost management with forecasted spending alerts

## Provider Configuration

This module requires specific provider configuration for subscription creation:

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

## Common Use Cases

### 1. Multi-Environment Setup
Create separate subscriptions for development, staging, and production environments.

### 2. Team Isolation
Provide isolated Azure subscriptions for different teams or projects.

### 3. Cost Management
Separate subscriptions for better cost tracking and budget management.

### 4. Compliance Requirements
Create subscriptions with specific configurations for regulatory compliance.

### 5. Workload Separation
Use subscription-level isolation for different workload types (Production vs DevTest).

## Security Considerations

1. **Billing Scope Access**: Ensure billing scope permissions are properly managed
2. **Management Group Association**: Use appropriate management group structure
3. **Resource Group Permissions**: Consider who needs access to management resource groups
4. **Budget Notifications**: Use appropriate contact lists for cost alerts
5. **Tags**: Use tags consistently for access control and cost allocation

## Troubleshooting

### Common Issues

1. **Insufficient Permissions**: Ensure proper Azure RBAC permissions for subscription creation
2. **Invalid Billing Scope**: Verify billing scope ID is valid and accessible
3. **Management Group Not Found**: Ensure management group exists and is accessible
4. **Budget Validation Errors**: Check budget configuration parameters
5. **Provider Configuration**: Ensure both default and subscription-specific providers are configured

### Best Practices

1. **Management Group Structure**: Use consistent management group hierarchy
2. **Naming Conventions**: Use consistent naming conventions across subscriptions
3. **Cost Management**: Implement budgets and alerts for cost control
4. **Tagging Strategy**: Use consistent tagging for governance and cost allocation
5. **Workload Classification**: Choose appropriate workload types for cost optimization

## Contributing

Contributions are welcome! Please read the contributing guidelines and submit pull requests to the main branch.

## License

This module is licensed under the **Apache License 2.0**, which means you can:

- ✅ **Use it freely** for any purpose (commercial or non-commercial)
- ✅ **Modify and distribute** your changes
- ✅ **Include it in proprietary software** without restriction
- ✅ **Use it forever** without worrying about license changes

The Apache License 2.0 is one of the most permissive open-source licenses, ensuring this module will always remain free and available for everyone. See [LICENSE](LICENSE) for the full license text.

## Support

For issues and questions:
- Check the [examples](./examples) directory
- Review the [Terraform Azure Provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- Open an issue in this repository