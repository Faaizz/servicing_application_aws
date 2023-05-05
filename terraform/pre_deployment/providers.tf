provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Project   = "Demo"
      Class     = "Pre-Deployment"
      ManagedBy = "Terraform"
      State     = "Local"
    }
  }
}
