output "api_url" {
  value       = module.api_gateway_deployment.invoke_url
  description = "invoke URL for API"
}
output "unlimited_api_key" {
  value       = module.api_gateway_deployment.unlimited_api_key
  description = "Unlimited API key"
}

output "queue_url" {
  value       = module.storage.codes_queue_url
  description = "URL of SQS queue for codes"
}

output "codes_dynamodb_table" {
  value       = module.storage.codes_dynamodb_table_id
  description = "DynamoDB table for storing codes"
}

output "verification_topic_arn" {
  value       = module.verification.sns_topic_arn
  description = "ARN of email verification SNS Topic"
}

output "worker_node_asus_1_access_key" {
  value       = aws_iam_access_key.worker_node_asus_1.id
  description = "Access key for worker node asus_1"
}
output "worker_node_asus_1_secret_key" {
  value       = aws_iam_access_key.worker_node_asus_1.secret
  description = "Secret key for worker node asus_1"
  sensitive   = true
}
