# Servicing Application on AWS

![terraform workflow](https://github.com/faaizz/servicing_application_aws/actions/workflows/terraform.yaml/badge.svg)

This repository holds skeleton code for a servicing application that is deployed on AWS.  

## CI
The CI pipeline is implemented with GitHub Actions.
On AWS, a dedicated CI account is deployed which manages CI/CD related processes. The GitHub OIDC provider is deployed in this account.  

Due to security requirements, the AWS account to which the resources are deployed is isolated from the CI account. Authentication to this account is provided via [role-chaining](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html).

Another peculiar feature of the CI pipeline is the dynamic generation of the terraform backend configuration, implemented as a bash script ([generate_backend.sh](scripts/generate_backend.sh)). This is to prevent hard-coding the backend S3 bucket to allow ease of testing.

The [terraform](.github/workflows/terraform.yaml) workflow performs validation of the terraform configuration in the various infrastructure modules and runs [TFLint](https://github.com/terraform-linters/tflint) against them.


## Frontend Application
The targeted [frontend application](terraform/frontend/README.md) is a [Next.js](https://nextjs.org/) web application.
The source repository and branch are supplied as terraform variables and the source code is pulled from GitHub using a GitHub personal access token (which is also supplied as a variable) for authentication.
The frontend application is deployed using the [AWS Amplify](https://docs.amplify.aws/guides/hosting/nextjs/q/platform/js/) service.  

One caveat of deploying with Amplify is that creating the "app" resource via terraform does not actually deploy the web application. The deployment needs to be triggered, for this a bash script ([deploy_frontend.sh](terraform/frontend/files/scripts/deploy_frontend.sh)) is used.


## Backend Service
The deployed [backend service](terraform/backend/README.md) consists of an S3 bucket (for storing processed artifacts), 2 DynamoDB tables (one for workload processing and the other for tracking node availability), an SQS queue (to accept requests from the frontend), an SNS topic, an API Gateway REST API, a Lambda layer, and 8 Lambda functions.  

The deployment is split into multiple [modules](terraform/backend/modules) to promote code reusability and improve readability and maintainability.  

Similar to the frontend application, the source code for the backend service is obtained from GitHub. 
The source repository is cloned using [a bash script](scripts/clone_git_repository.sh) which is called from a terraform provisioner.
