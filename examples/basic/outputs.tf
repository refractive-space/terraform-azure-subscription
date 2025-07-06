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