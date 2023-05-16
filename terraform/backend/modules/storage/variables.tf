variable "results_bucket_name" {
  type        = string
  description = "Name of the S3 bucket where the results will be stored"
}

variable "codes_table_name" {
  type        = string
  description = "Name of the DynamoDB table where the codes information will be stored"
}
variable "nodes_table_name" {
  type        = string
  description = "Name of the DynamoDB table where the nodes status will be stored"
}

variable "codes_queue_name" {
  type        = string
  description = "Name of the SQS queue where the codes will be sent to be processed"
}
