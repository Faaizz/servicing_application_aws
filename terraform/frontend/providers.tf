provider "aws" {
  default_tags {
    tags = {
      Project   = "Demo"
      Class     = "Frontend"
      ManagedBy = "Terraform"
      State     = "S3"
    }
  }
}
