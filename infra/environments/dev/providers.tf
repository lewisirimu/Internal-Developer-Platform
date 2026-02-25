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
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = "dev"
      ManagedBy   = "terraform"
      Platform    = "ml-idp"
    }
  }
}

# Mock kubernetes provider configuration
provider "kubernetes" {
  config_path = "~/.kube/config"
}
