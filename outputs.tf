# The ID of the created Azure subscription
output "subscription_id" {
  description = "The ID of the Azure subscription"
  value       = azurerm_subscription.this.subscription_id
}

# The tenant ID of the subscription
output "tenant_id" {
  description = "The tenant ID of the Azure subscription"
  value       = azurerm_subscription.this.tenant_id
}

# The subscription name
output "subscription_name" {
  description = "The name of the Azure subscription"
  value       = local.subscription_name
}

# The display name of the subscription
output "display_name" {
  description = "The display name of the Azure subscription"
  value       = local.display_name
}

# The workload type of the subscription
output "workload_type" {
  description = "The workload type of the Azure subscription"
  value       = local.workload_type
}

# The management group association ID (if created)
output "management_group_association_id" {
  description = "The ID of the management group association, if created"
  value       = var.management_group_id != "" ? azurerm_management_group_subscription_association.this[0].id : null
}

# The budget ID (if created)
output "budget_id" {
  description = "The ID of the subscription budget, if created"
  value       = var.create_budget ? azurerm_consumption_budget_subscription.this[0].id : null
}

# The budget name (if created)
output "budget_name" {
  description = "The name of the subscription budget, if created"
  value       = var.create_budget ? azurerm_consumption_budget_subscription.this[0].name : null
}

# The budget amount (if created)
output "budget_amount" {
  description = "The amount of the subscription budget, if created"
  value       = var.create_budget ? var.budget_amount : null
}

# The generated UUID used for auto-naming
output "generated_uuid" {
  description = "The generated UUID used for auto-naming when values are not provided"
  value       = random_uuid.name.result
}

# The computed alias used for the subscription
output "alias" {
  description = "The alias used for the Azure subscription"
  value       = local.alias
}

# The billing scope ID used for the subscription
output "billing_scope_id" {
  description = "The billing scope ID used for the Azure subscription"
  value       = local.billing_scope_id
}

# The billing account name (if provided)
output "billing_account_name" {
  description = "The billing account name used for the subscription"
  value       = var.billing_account_name != "" ? var.billing_account_name : null
}

# The billing profile name (if provided)
output "billing_profile_name" {
  description = "The billing profile name used for the subscription"
  value       = var.billing_profile_name != "" ? var.billing_profile_name : null
}

# The invoice section name (if provided)
output "invoice_section_name" {
  description = "The invoice section name used for the subscription"
  value       = var.invoice_section_name != "" ? var.invoice_section_name : null
}