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
          module.storage.codes_queue_arn,
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
          module.storage.codes_dynamodb_table_arn,
          module.storage.nodes_dynamodb_table_arn,
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
