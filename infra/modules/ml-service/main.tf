resource "kubernetes_namespace" "ml_service" {
  metadata {
    name = var.service_name
    labels = {
      "istio-injection" = "enabled" # Enforce mTLS
      "environment"     = var.environment
      "managed-by"      = "terraform"
    }
  }
}

resource "kubernetes_service_account" "ml_service" {
  metadata {
    name      = "${var.service_name}-sa"
    namespace = kubernetes_namespace.ml_service.metadata[0].name
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.ml_service_role.arn
    }
  }
}

data "aws_iam_policy_document" "ml_service_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_provider_url}:sub"
      values   = ["system:serviceaccount:${var.service_name}:${var.service_name}-sa"]
    }
  }
}

resource "aws_iam_role" "ml_service_role" {
  name               = "${var.service_name}-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.ml_service_assume_role.json
}

# Example AWS Budget for the service to prevent runaway costs
resource "aws_budgets_budget" "service_budget" {
  name         = "${var.service_name}-budget-${var.environment}"
  budget_type  = "COST"
  limit_amount = var.monthly_budget_limit
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.team_email]
  }
}
