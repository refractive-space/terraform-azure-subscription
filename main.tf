# Generate random UUID for unique naming when values not provided
resource "random_uuid" "name" {}

# Validation to ensure either billing_scope_id or all billing components are provided
resource "null_resource" "billing_validation" {
  count = (var.billing_scope_id == "" && (var.billing_account_name == "" || var.billing_profile_name == "" || var.invoice_section_name == "")) || (var.billing_scope_id != "" && var.billing_account_name != "") ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'Error: Either provide billing_scope_id OR all three billing components (billing_account_name, billing_profile_name, invoice_section_name)' && exit 1"
  }
}

# Get billing scope from MCA account components (if provided)
data "azurerm_billing_mca_account_scope" "this" {
  count                = var.billing_account_name != "" ? 1 : 0
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name
}

# Local values for subscription creation
locals {
  # Use provided display_name or generated UUID
  display_name = var.display_name == "" ? random_uuid.name.result : var.display_name

  # Use provided subscription_name, fallback to display_name, or use UUID
  subscription_name = var.subscription_name == "" ? local.display_name : var.subscription_name

  # Use provided alias or generated UUID
  alias = var.alias == "" ? random_uuid.name.result : var.alias

  # Normalize subscription name for consistent naming (lowercase, spaces to hyphens)
  normalised_name = replace(lower(local.subscription_name), " ", "-")

  # Generate workload type for subscription
  workload_type = var.workload_type == "" ? "Production" : var.workload_type

  # Determine billing scope ID - use data source if components provided, otherwise use direct billing_scope_id
  billing_scope_id = var.billing_account_name != "" ? data.azurerm_billing_mca_account_scope.this[0].id : var.billing_scope_id
}

# Create the Azure subscription
resource "azurerm_subscription" "this" {
  alias             = local.alias
  billing_scope_id  = local.billing_scope_id
  subscription_name = local.subscription_name
  workload          = local.workload_type

  tags = var.tags
}

# Move subscription to management group if specified
resource "azurerm_management_group_subscription_association" "this" {
  count                = var.management_group_id != "" ? 1 : 0
  management_group_id  = var.management_group_id
  subscription_id      = "/subscriptions/${azurerm_subscription.this.subscription_id}"
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