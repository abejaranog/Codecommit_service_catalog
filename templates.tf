data "archive_file" "base_repo" {
  type        = "zip"
  source_dir = "${path.module}/init-repo/base"
  output_path = "${local.zip_output_path}/base.zip"
}

data "archive_file" "buildspec_repo" {
  type        = "zip"
  source_dir = "${path.module}/init-repo/buildspec"
  output_path = "${local.zip_output_path}/buildspec.zip"
}
