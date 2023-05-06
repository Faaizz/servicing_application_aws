data "archive_file" "lambda_layer" {
  type             = "zip"
  source_dir       = local.lambda_layer_code_path
  output_file_mode = "0666"
  output_path      = local.source_zip_path
}
