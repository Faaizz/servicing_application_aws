output "invoke_url" {
  description = "invoke URL for API"
  value       = aws_api_gateway_stage.core_dev.invoke_url
}
output "unlimited_api_key" {
  description = "Unlimited API key"
  value       = aws_api_gateway_usage_plan_key.core_unlimited.value
}
