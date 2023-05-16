resource "aws_lambda_layer_version" "base_layer" {
  filename            = var.source_zip_path
  layer_name          = var.name
  compatible_runtimes = ["python3.9"]
  source_code_hash    = can(filesha256(var.source_zip_path)) ? filesha256(var.source_zip_path) : ""
}
