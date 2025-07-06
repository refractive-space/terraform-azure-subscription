# Complete Example

This example demonstrates a full-featured Azure subscription configuration with all module capabilities enabled.

## What This Example Creates

- Azure subscription with Production workload type
- Management group association
- Management resource group for infrastructure resources
- Budget with multiple notification thresholds
- Comprehensive tagging strategy
- Custom subscription name and alias

## Configuration Highlights

### Subscription Configuration
- **Display Name**: "Production Subscription"
- **Subscription Name**: "production-sub"
- **Alias**: "production-alias" (for programmatic access)
- **Workload Type**: "Production" (standard pricing)
- **Management Group**: Associated with "production-mg"

### Management Resource Group
- **Name**: "production-management-rg"
- **Location**: "East US"
- **Purpose**: Container for infrastructure management resources

### Budget Configuration
- **Amount**: $5,000 per month
- **Time Grain**: Monthly
- **Duration**: Full year (2024-01-01 to 2024-12-31)
- **Notifications**: Three-tier alert system

### Budget Notifications
1. **70% Threshold**: Early warning to administrators
2. **85% Threshold**: Urgent alert to admins and finance team
3. **100% Forecasted**: Proactive alert when forecasted to exceed budget

## Prerequisites

Before running this example, you need:

1. **Azure CLI** authenticated to your tenant
2. **Terraform** >= 1.8.0 installed
3. **Billing scope permissions** to create subscriptions
4. **Valid billing scope ID** (replace the example ID with your actual billing scope)
5. **Management group "production-mg"** created and accessible
6. **Email addresses** for budget notifications configured

## Required Updates

Update these values in `main.tf` before applying:

1. **Billing Scope ID**: Replace with your actual billing scope ID
2. **Management Group ID**: Replace "production-mg" with your management group ID
3. **Email Addresses**: Update contact emails for budget notifications
4. **Resource Group Location**: Choose your preferred Azure region
5. **Tags**: Customize tags to match your organization's strategy

## Usage

1. **Update the configuration** with your specific values
2. **Initialize and apply**:

```bash
terraform init
terraform plan
terraform apply
```

## Outputs

This example outputs comprehensive information about all created resources:

- **Subscription Details**: ID, name, tenant ID
- **Management Group**: Association ID
- **Resource Group**: ID, name, location
- **Budget**: ID, name, amount

## Best Practices Demonstrated

### 1. Comprehensive Tagging
```hcl
tags = {
  Environment    = "Production"
  BusinessUnit   = "Engineering"
  CostCenter     = "123456"
  ManagedBy      = "Terraform"
  Owner          = "platform-team@example.com"
  Project        = "Core Infrastructure"
  DataClass      = "Internal"
}
```

### 2. Multi-Tier Budget Alerts
- **70%**: Early warning (administrators only)
- **85%**: Urgent alert (administrators + finance)
- **100% forecasted**: Proactive cost management

### 3. Resource Organization
- Management resource group for infrastructure resources
- Clear naming conventions
- Logical grouping of resources

### 4. Cost Management
- Appropriate budget amounts for workload type
- Multiple notification thresholds
- Forecasted spending alerts

## Security Considerations

1. **Email Notifications**: Ensure notification emails are properly secured
2. **Management Group Access**: Verify appropriate permissions
3. **Resource Group Permissions**: Plan access control for management resources
4. **Budget Alerts**: Configure appropriate escalation procedures

## Post-Deployment Steps

After successful deployment:

1. **Verify Budget Alerts**: Test notification delivery
2. **Configure RBAC**: Set up role-based access control
3. **Apply Policies**: Implement Azure policies through management group
4. **Set Up Monitoring**: Configure additional monitoring and alerting
5. **Document Access**: Update documentation with new subscription details

## Troubleshooting

Common issues and solutions:

1. **Management Group Not Found**: Ensure the management group exists and you have access
2. **Budget Validation Errors**: Check email addresses and notification configuration
3. **Billing Scope Access**: Verify permissions to create subscriptions
4. **Provider Configuration**: Ensure both providers are properly configured

## Next Steps

Consider these additional configurations:

1. **Azure Policy**: Apply governance policies through management groups
2. **RBAC**: Set up role-based access control
3. **Monitoring**: Configure Azure Monitor and Log Analytics
4. **Networking**: Set up virtual networks and connectivity
5. **Security**: Implement Azure Security Center and Key Vault