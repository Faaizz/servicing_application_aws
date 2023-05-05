terraform {
  required_version = "~>1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.53.0"
    }
  }

  backend "s3" {
    region = "eu-central-1"
    bucket = "faaizz-demo-terraform-state"
    key    = "frontend.tfstate"
  }
}
