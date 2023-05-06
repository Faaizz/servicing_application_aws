locals {
  base_directory         = "${path.root}/../.."
  source_code_path       = abspath("${local.base_directory}/${var.source_code_suffix}/src/python")
  lambda_layer_code_path = abspath("${local.base_directory}/${var.source_code_suffix}/src")
  source_zip_path        = "/tmp/deploy_files/extractor.zip"
}
