# Get source code
resource "null_resource" "get_source_code" {
  provisioner "local-exec" {
    working_dir = var.base_directory
    interpreter = ["/bin/bash", "-c"]
    command     = "./scripts/clone_git_repository.sh ${var.github_repo_url} ${var.source_code_suffix}"
  }
}
