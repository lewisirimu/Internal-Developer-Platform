# Dev Environment Root Module

# Mock values for the example platform setup
locals {
  environment       = "dev"
  oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.region.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE"
  oidc_provider_url = "oidc.eks.region.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE"
}

# The IDP platform CLI scripts append service modules to the end of this file automatically.

# module "ml_service_example" {
#   source               = "../../modules/ml-service"
#   service_name         = "example-model"
#   environment          = local.environment
#   oidc_provider_arn    = local.oidc_provider_arn
#   oidc_provider_url    = local.oidc_provider_url
#   monthly_budget_limit = "50"
# }

module "ml_service_fraud-model" {
  source       = "../../modules/ml-service"
  service_name = "fraud-model"
  environment  = "dev"
}

module "ml_service_test" {
  source       = "../../modules/ml-service"
  service_name = "test"
  environment  = "dev"
}
