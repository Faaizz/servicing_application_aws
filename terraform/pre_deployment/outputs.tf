output "s3_bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "The name of the S3 bucket to store terraform states"
}
