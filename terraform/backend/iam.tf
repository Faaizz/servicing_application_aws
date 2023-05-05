# API Gateway CW Logs Access
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

# Worker Node Permissions
resource "aws_iam_group" "worker_nodes" {
  name = "worker_nodes"
}
resource "aws_iam_group_policy" "worker_nodes" {
  name_prefix = "main-"
  group       = aws_iam_group.worker_nodes.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CodecheckAccessSQS"
        Effect = "Allow"
        Action = [
          "sqs:*",
        ]
        Resource = [
          aws_sqs_queue.codes.arn,
        ]
      },
      {
        Sid    = "CodecheckAccessSNS"
        Effect = "Allow"
        Action = [
          "sns:*",
        ]
        Resource = [
          module.verification.sns_topic_arn,
        ]
      },
      {
        Sid    = "CodecheckAccessDDB"
        Effect = "Allow"
        Action = [
          "dynamodb:*",
        ]
        Resource = [
          module.dynamodb_codes.dynamodb_table_arn,
          module.dynamodb_node_status.dynamodb_table_arn,
        ]
      },
    ]
  })
}

resource "aws_iam_user" "worker_node_asus_1" {
  name = "worker_node_asus_1"
}
resource "aws_iam_access_key" "worker_node_asus_1" {
  user = aws_iam_user.worker_node_asus_1.name
}
resource "aws_iam_user_group_membership" "worker_node_asus_1" {
  user = aws_iam_user.worker_node_asus_1.name

  groups = [
    aws_iam_group.worker_nodes.name,
  ]
}
