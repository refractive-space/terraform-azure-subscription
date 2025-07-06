# The display name of the subscription
variable "display_name" {
  description = "The display name of the Azure subscription to create. If empty, will be auto-generated using random UUID"
  type        = string
  default     = ""

  validation {
    condition     = var.display_name == "" || (length(var.display_name) > 0 && length(var.display_name) <= 64)
    error_message = "Subscription display name must be between 1 and 64 characters or empty string."
  }
}

# The subscription name (optional, defaults to display_name)
variable "subscription_name" {
  description = "The name of the Azure subscription. If empty, will use display_name or auto-generated UUID"
  type        = string
  default     = ""

  validation {
    condition     = var.subscription_name == "" || (length(var.subscription_name) > 0 && length(var.subscription_name) <= 64)
    error_message = "Subscription name must be between 1 and 64 characters or empty string."
  }
}

# The alias for the subscription (optional, for programmatic access)
variable "alias" {
  description = "The alias for the Azure subscription (for programmatic access). If empty, will be auto-generated using random UUID"
  type        = string
  default     = ""

  validation {
    condition     = var.alias == "" || can(regex("^[a-zA-Z0-9-_]+$", var.alias))
    error_message = "Subscription alias must contain only alphanumeric characters, hyphens, and underscores or empty string."
  }
}

# The billing scope ID for the subscription (alternative to using billing account components)
variable "billing_scope_id" {
  description = "The billing scope ID for the Azure subscription. If empty, will be determined from billing account components"
  type        = string
  default     = ""

  validation {
    condition     = var.billing_scope_id == "" || can(regex("^/providers/Microsoft\\.Billing/billingAccounts/[^/]+", var.billing_scope_id))
    error_message = "Billing scope ID must be a valid Azure billing scope resource ID or empty string."
  }
}

# The billing account name (MCA account identifier)
variable "billing_account_name" {
  description = "The billing account name for MCA subscriptions (e.g., 'd0af5c57-9e26-51a3-83dd-7016c847c58d:a511b608-e4a4-4ab1-96b7-430b05b7d1a2_2019-05-31')"
  type        = string
  default     = ""

  validation {
    condition     = var.billing_account_name == "" || can(regex("^[a-f0-9-]{36}:[a-f0-9-]{36}_[0-9]{4}-[0-9]{2}-[0-9]{2}$", var.billing_account_name))
    error_message = "Billing account name must be in the format 'guid:guid_yyyy-mm-dd' or empty string."
  }
}

# The billing profile name within the billing account
variable "billing_profile_name" {
  description = "The billing profile name within the billing account (e.g., 'WJSQ-JV2N-BG7-PGB')"
  type        = string
  default     = ""

  validation {
    condition     = var.billing_profile_name == "" || can(regex("^[A-Z0-9-]+$", var.billing_profile_name))
    error_message = "Billing profile name must contain only uppercase letters, numbers, and hyphens or empty string."
  }
}

# The invoice section name within the billing profile
variable "invoice_section_name" {
  description = "The invoice section name within the billing profile (e.g., 'S3TC-J744-PJA-PGB')"
  type        = string
  default     = ""

  validation {
    condition     = var.invoice_section_name == "" || can(regex("^[A-Z0-9-]+$", var.invoice_section_name))
    error_message = "Invoice section name must contain only uppercase letters, numbers, and hyphens or empty string."
  }
}

# The workload type for the subscription
variable "workload_type" {
  description = "The workload type for the Azure subscription"
  type        = string
  default     = "Production"

  validation {
    condition     = contains(["Production", "DevTest"], var.workload_type)
    error_message = "Workload type must be either Production or DevTest."
  }
}

# The management group ID to associate the subscription with
variable "management_group_id" {
  description = "The management group ID to associate the subscription with. If empty, subscription will remain in tenant root"
  type        = string
  default     = ""

  validation {
    condition = var.management_group_id == "" || can(regex("^[a-zA-Z0-9-_\\.\\(\\)]+$", var.management_group_id)) || can(regex("^/providers/Microsoft\\.Management/managementGroups/[a-zA-Z0-9-_\\.\\(\\)]+$", var.management_group_id))
    error_message = "Management group ID must be a simple ID (alphanumeric characters, hyphens, underscores, periods, and parentheses) or a full Azure resource ID."
  }
}

# Note: Resource group creation within the subscription should be done in a separate
# configuration after the subscription is created, as it requires subscription-level provider configuration

# Whether to create a budget for the subscription
variable "create_budget" {
  description = "Whether to create a budget for the subscription"
  type        = bool
  default     = false
}

# The name of the budget
variable "budget_name" {
  description = "The name of the budget. If empty, will be auto-generated"
  type        = string
  default     = ""

  validation {
    condition     = var.budget_name == "" || can(regex("^[a-zA-Z0-9-_\\.\\(\\)]+$", var.budget_name))
    error_message = "Budget name must contain only alphanumeric characters, hyphens, underscores, periods, and parentheses."
  }
}

# The budget amount
variable "budget_amount" {
  description = "The budget amount for the subscription"
  type        = number
  default     = 1000

  validation {
    condition     = var.budget_amount > 0
    error_message = "Budget amount must be greater than 0."
  }
}

# The budget time grain
variable "budget_time_grain" {
  description = "The time grain for the budget (Monthly, Quarterly, Annually)"
  type        = string
  default     = "Monthly"

  validation {
    condition     = contains(["Monthly", "Quarterly", "Annually"], var.budget_time_grain)
    error_message = "Budget time grain must be Monthly, Quarterly, or Annually."
  }
}

# The budget start date
variable "budget_start_date" {
  description = "The start date for the budget (YYYY-MM-DD format)"
  type        = string
  default     = ""

  validation {
    condition     = var.budget_start_date == "" || can(regex("^\\d{4}-\\d{2}-\\d{2}$", var.budget_start_date))
    error_message = "Budget start date must be in YYYY-MM-DD format or empty string."
  }
}

# The budget end date
variable "budget_end_date" {
  description = "The end date for the budget (YYYY-MM-DD format). If empty, budget will not expire"
  type        = string
  default     = ""

  validation {
    condition     = var.budget_end_date == "" || can(regex("^\\d{4}-\\d{2}-\\d{2}$", var.budget_end_date))
    error_message = "Budget end date must be in YYYY-MM-DD format or empty string."
  }
}

# Budget notifications configuration
variable "budget_notifications" {
  description = "List of budget notifications to configure"
  type = list(object({
    enabled        = bool
    threshold      = number
    operator       = string
    threshold_type = string
    contact_emails = list(string)
    contact_groups = list(string)
    contact_roles  = list(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for notification in var.budget_notifications : contains(["EqualTo", "GreaterThan", "GreaterThanOrEqualTo"], notification.operator)
    ])
    error_message = "Budget notification operator must be EqualTo, GreaterThan, or GreaterThanOrEqualTo."
  }

  validation {
    condition = alltrue([
      for notification in var.budget_notifications : contains(["Actual", "Forecasted"], notification.threshold_type)
    ])
    error_message = "Budget notification threshold type must be Actual or Forecasted."
  }

  validation {
    condition = alltrue([
      for notification in var.budget_notifications : notification.threshold > 0 && notification.threshold <= 1000
    ])
    error_message = "Budget notification threshold must be between 0 and 1000."
  }
}

# Tags to apply to all resources
variable "tags" {
  description = "A map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}