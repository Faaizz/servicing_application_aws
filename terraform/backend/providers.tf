provider "aws" {
  default_tags {
    tags = {
      Project   = "Demo"
      Class     = "Backend"
      ManagedBy = "Terraform"
      State     = "S3"
    }
  }
}
