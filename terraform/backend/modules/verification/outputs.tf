output "sns_topic_arn" {
  value       = aws_sns_topic.verification.arn
  description = "SNS topic arn"
}
