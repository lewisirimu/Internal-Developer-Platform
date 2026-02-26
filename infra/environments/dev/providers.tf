terraform {
  required_version = ">= 1.3.0"

  # backend "s3" {
  #   bucket = "my-org-terraform-state"
  #   key    = "idp/dev/terraform.tfstate"
  #   region = "us-east-1"
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  default_tags {
    tags = {
      Environment = "dev"
      ManagedBy   = "terraform"
      Platform    = "ml-idp"
    }
  }
}

# Mock kubernetes provider configuration for CI environments
provider "kubernetes" {
  host = "https://mock-cluster.example.com"
}
