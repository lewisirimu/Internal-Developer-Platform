variable "service_name" {
  description = "Name of the ML service being deployed"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "monthly_budget_limit" {
  description = "Monthly budget limit in USD"
  type        = string
  default     = "100"
}

variable "team_email" {
  description = "Email address for budget alerts"
  type        = string
  default     = "ml-platform-alerts@example.com"
}

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN for EKS IRSA"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC Provider URL for EKS IRSA"
  type        = string
}
