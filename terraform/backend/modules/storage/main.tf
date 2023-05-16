# S3 Buckets
resource "aws_s3_bucket" "results" {
  bucket        = var.results_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_lifecycle_configuration" "extracted_orders" {
  bucket = aws_s3_bucket.results.id

  rule {
    id = "expire_order_extraction_files"

    filter {
      prefix = "extracted_order/"
    }

    expiration {
      days = 1
    }

    status = "Enabled"
  }
}


# DynamoDB tables
module "dynamodb_codes" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.2.0"

  name     = var.codes_table_name
  hash_key = "id"

  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  ttl_enabled        = true
  ttl_attribute_name = "ttl"

  attributes = [
    {
      name = "id"
      type = "S"
    }
  ]
}

module "dynamodb_node_status" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.2.0"

  name     = var.nodes_table_name
  hash_key = "id"

  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  ttl_enabled        = true
  ttl_attribute_name = "ttl"

  attributes = [
    {
      name = "id"
      type = "S"
    }
  ]
}


# SQS Queues
resource "aws_sqs_queue" "codes" {
  name                       = var.codes_queue_name
  visibility_timeout_seconds = 600
}
