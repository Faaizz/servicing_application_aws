output "id" {
  description = "ID of the API Gateway"
  value       = aws_api_gateway_rest_api.core.id
}
output "root_resource_id" {
  description = "ID of the root resource"
  value       = aws_api_gateway_rest_api.core.root_resource_id
}
output "execution_arn" {
  description = "ARN of the API Gateway execution"
  value       = aws_api_gateway_rest_api.core.execution_arn
}
