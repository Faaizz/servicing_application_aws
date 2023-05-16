output "codes_queue_arn" {
  description = "ARN of the SQS queue where the codes will be sent to be processed"
  value       = aws_sqs_queue.codes.arn
}
output "codes_queue_url" {
  description = "URL of the SQS queue where the codes will be sent to be processed"
  value       = aws_sqs_queue.codes.url
}

output "results_bucket_id" {
  description = "ID of the S3 bucket where the results will be stored"
  value       = aws_s3_bucket.results.bucket
}
output "results_bucket_arn" {
  description = "ARN of the S3 bucket where the results will be stored"
  value       = aws_s3_bucket.results.arn
}


output "codes_dynamodb_table_id" {
  description = "ID of the DynamoDB table where the codes information will be stored"
  value       = module.dynamodb_codes.dynamodb_table_id
}
output "codes_dynamodb_table_arn" {
  description = "ARN of the DynamoDB table where the codes information will be stored"
  value       = module.dynamodb_codes.dynamodb_table_arn
}


output "nodes_dynamodb_table_id" {
  description = "ID of the DynamoDB table where the nodes status will be stored"
  value       = module.dynamodb_node_status.dynamodb_table_id
}
output "nodes_dynamodb_table_arn" {
  description = "ARN of the DynamoDB table where the nodes status will be stored"
  value       = module.dynamodb_node_status.dynamodb_table_arn
}
