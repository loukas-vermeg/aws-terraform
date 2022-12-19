terraform {
   cloud {
    organization = "mbenyedder"

    workspaces {
      name = "example-workspace"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.47.0"
    }
   
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

