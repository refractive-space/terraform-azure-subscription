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
  value       = var.display_name
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

# The management resource group ID (if created)
output "management_resource_group_id" {
  description = "The ID of the management resource group, if created"
  value       = var.create_management_resource_group ? azurerm_resource_group.management[0].id : null
}

# The management resource group name (if created)
output "management_resource_group_name" {
  description = "The name of the management resource group, if created"
  value       = var.create_management_resource_group ? azurerm_resource_group.management[0].name : null
}

# The management resource group location (if created)
output "management_resource_group_location" {
  description = "The location of the management resource group, if created"
  value       = var.create_management_resource_group ? azurerm_resource_group.management[0].location : null
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