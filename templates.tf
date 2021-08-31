data "archive_file" "base_repo" {
  type        = "zip"
  source_dir = "${path.module}/init-repo/base"
  output_path = "${local.zip_output_path}/base.zip"
}

data "archive_file" "terraform_repo" {
  type        = "zip"
  source_dir = "${path.module}/init-repo/terraform"
  output_path = "${local.zip_output_path}/terraform.zip"
}
