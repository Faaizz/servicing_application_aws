resource "aws_iam_role" "amplify_service" {
  name_prefix = "AmplifyServiceRole-"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "amplify.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "CWLogs"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogStream",
            "logs:CreateLogGroup",
            "logs:DescribeLogGroups",
            "logs:PutLogEvents",
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_amplify_app" "core_frontend" {
  name         = "core_frontend"
  repository   = var.github_repo_url
  access_token = var.github_access_token

  platform             = "WEB_COMPUTE"
  iam_service_role_arn = aws_iam_role.amplify_service.arn

  build_spec = <<-EOF
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - echo installing dependencies
            - npm ci
        build:
          commands:
            - echo build started on `date`
            - echo passing environment variables
            - env | grep -e API_URL >> .env.production
            - env | grep -e OE_QUEUE_BACKEND_URL -e OE_POLL_BACKEND_URL -e OE_RESULT_BACKEND_URL >> .env.production
            - env | grep -e M_QUEUE_BACKEND_URL -e M_POLL_BACKEND_URL >> .env.production
            - env | grep -e V_EMAIL_BACKEND_URL -e V_CODE_BACKEND_URL -e V_SUBSCRIPTION_BACKEND_URL >> .env.production
            - env | grep -e NODE_STATUS_URL -e API_KEY >> .env.production
            - echo compiling javascript
            - npm run build
      artifacts:
        baseDirectory: .next
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOF

  environment_variables = {
    API_URL                    = local.api_invoke_url
    OE_QUEUE_BACKEND_URL       = "${local.api_invoke_url}/orderextraction/queue"
    OE_POLL_BACKEND_URL        = "${local.api_invoke_url}/orderextraction/poll"
    OE_RESULT_BACKEND_URL      = "${local.api_invoke_url}/orderextraction/result"
    M_QUEUE_BACKEND_URL        = "${local.api_invoke_url}/codechecker/queue"
    M_POLL_BACKEND_URL         = "${local.api_invoke_url}/codechecker/poll"
    V_EMAIL_BACKEND_URL        = "${local.api_invoke_url}/verification/email"
    V_CODE_BACKEND_URL         = "${local.api_invoke_url}/verification/code"
    V_SUBSCRIPTION_BACKEND_URL = "${local.api_invoke_url}/verification/subscription"
    NODE_STATUS_URL            = "${local.api_invoke_url}/status/node"
    API_KEY                    = data.terraform_remote_state.backend.outputs.unlimited_api_key
  }

  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }
  # Dynamic routes for verification code
  custom_rule {
    source = "/services/${var.core_backend_service}/verification/code/<*>"
    status = "200"
    target = "/services/${var.core_backend_service}/verification/code/[id].html"
  }
  # Dynamic routes for verification email
  custom_rule {
    source = "/services/${var.core_backend_service}/verification/email/<*>"
    status = "200"
    target = "/services/${var.core_backend_service}/verification/email/[id].html"
  }

  lifecycle {
    ignore_changes = [
      custom_rule,
    ]
  }
}

resource "aws_amplify_branch" "main" {
  # Adds webhooks on the GitHub repository and does not delete them on terraform destroy
  app_id      = aws_amplify_app.core_frontend.id
  branch_name = var.github_repo_branch

  #  deploy frontend
  provisioner "local-exec" {
    environment = {
      APP_ID      = aws_amplify_app.core_frontend.id
      BRANCH_NAME = var.github_repo_branch
    }

    working_dir = join("/", [abspath(path.root), "files", "scripts"])
    interpreter = [
      "/bin/bash", "-c"
    ]

    command = <<-EOF
    ./deploy_frontend.sh
    EOF
  }
}
