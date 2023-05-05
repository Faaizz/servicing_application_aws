resource "aws_iam_role" "api_gw_to_s3" {
  name_prefix = "APIGWToS3"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "api_gw_to_s3" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "ListObjectsInBucket"
        Action = [
          "s3:ListBucket"
        ],
        Effect   = "Allow"
        Resource = [var.result_bucket_arn]
      },
      {
        Sid = "AllObjectActions"
        Action = [
          "s3:*Object",
        ]
        Effect   = "Allow"
        Resource = ["${var.result_bucket_arn}/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "api_gw_to_s3" {
  role       = aws_iam_role.api_gw_to_s3.name
  policy_arn = aws_iam_policy.api_gw_to_s3.arn
}
