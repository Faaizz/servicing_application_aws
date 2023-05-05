terraform {
  required_version = "~>1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.63.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }

  backend "s3" {
    region = "eu-central-1"
    bucket = "faaizz-demo-terraform-state"
    key    = "backend.tfstate"
  }
}
