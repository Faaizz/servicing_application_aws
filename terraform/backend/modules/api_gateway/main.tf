# CW Logs Access
resource "aws_iam_role" "api_gw_to_cloudwatch" {
  name_prefix = "api_gateway_cloudwatch_global"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_policy" "api_gw_to_cloudwatch" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:FilterLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "api_gw_to_cloudwatch" {
  role       = aws_iam_role.api_gw_to_cloudwatch.name
  policy_arn = aws_iam_policy.api_gw_to_cloudwatch.arn
}


# API Gateway
resource "aws_api_gateway_account" "current" {
  cloudwatch_role_arn = aws_iam_role.api_gw_to_cloudwatch.arn
}
resource "aws_api_gateway_rest_api" "core" {
  name = "core-api"
}
