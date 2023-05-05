data "archive_file" "extractor" {
  type             = "zip"
  source_dir       = var.source_code_path
  output_file_mode = "0666"
  output_path      = local.source_zip_path
}
