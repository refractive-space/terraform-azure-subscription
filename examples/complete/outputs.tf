output "subscription_id" {
  description = "The ID of the created Azure subscription"
  value       = module.subscription.subscription_id
}

output "subscription_name" {
  description = "The name of the created Azure subscription"
  value       = module.subscription.subscription_name
}

output "tenant_id" {
  description = "The tenant ID of the Azure subscription"
  value       = module.subscription.tenant_id
}

output "management_group_association_id" {
  description = "The ID of the management group association"
  value       = module.subscription.management_group_association_id
}

output "management_resource_group_id" {
  description = "The ID of the management resource group"
  value       = module.subscription.management_resource_group_id
}

output "management_resource_group_name" {
  description = "The name of the management resource group"
  value       = module.subscription.management_resource_group_name
}

output "budget_id" {
  description = "The ID of the subscription budget"
  value       = module.subscription.budget_id
}

output "budget_name" {
  description = "The name of the subscription budget"
  value       = module.subscription.budget_name
}

output "budget_amount" {
  description = "The amount of the subscription budget"
  value       = module.subscription.budget_amount
}