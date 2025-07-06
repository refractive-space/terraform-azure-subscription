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

output "generated_uuid" {
  description = "The UUID used for auto-generation"
  value       = module.subscription.generated_uuid
}

output "display_name" {
  description = "The computed display name (auto-generated in this example)"
  value       = module.subscription.display_name
}

output "alias" {
  description = "The computed alias (auto-generated in this example)"
  value       = module.subscription.alias
}