output "namespace" {
  value = kubernetes_namespace.ml_service.metadata[0].name
}

output "iam_role_arn" {
  value = aws_iam_role.ml_service_role.arn
}

output "service_account_name" {
  value = kubernetes_service_account.ml_service.metadata[0].name
}
