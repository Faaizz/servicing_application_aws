output "arn" {
  description = "ARN of the Lambda Layer"
  value       = aws_lambda_layer_version.base_layer.arn
}
