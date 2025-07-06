# Local values for subscription creation
locals {
  # Generate subscription name if not provided using display_name
  subscription_name = var.subscription_name == "" ? var.display_name : var.subscription_name
  
  # Normalize subscription name for consistent naming (lowercase, spaces to hyphens)
  normalised_name = replace(lower(local.subscription_name), " ", "-")
  
  # Generate workload type for subscription
  workload_type = var.workload_type == "" ? "Production" : var.workload_type
}

# Create the Azure subscription
resource "azurerm_subscription" "this" {
  alias             = var.alias
  billing_scope_id  = var.billing_scope_id
  subscription_name = local.subscription_name
  workload          = local.workload_type
  
  tags = var.tags
}

# Move subscription to management group if specified
resource "azurerm_management_group_subscription_association" "this" {
  count                = var.management_group_id != "" ? 1 : 0
  management_group_id  = var.management_group_id
  subscription_id      = azurerm_subscription.this.subscription_id
}

# Create budget for the subscription if specified
resource "azurerm_consumption_budget_subscription" "this" {
  count           = var.create_budget ? 1 : 0
  name            = var.budget_name == "" ? "${local.normalised_name}-budget" : var.budget_name
  subscription_id = azurerm_subscription.this.subscription_id
  
  amount     = var.budget_amount
  time_grain = var.budget_time_grain
  
  time_period {
    start_date = var.budget_start_date
    end_date   = var.budget_end_date
  }
  
  dynamic "notification" {
    for_each = var.budget_notifications
    content {
      enabled         = notification.value.enabled
      threshold       = notification.value.threshold
      operator        = notification.value.operator
      threshold_type  = notification.value.threshold_type
      contact_emails  = notification.value.contact_emails
      contact_groups  = notification.value.contact_groups
      contact_roles   = notification.value.contact_roles
    }
  }
  
  depends_on = [azurerm_subscription.this]
}