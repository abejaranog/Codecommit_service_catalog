resource "aws_s3_bucket" "cf_templates" {
    bucket = "sandbox-abg-cf-templates"
}

resource "aws_s3_bucket_object" "template" {
  bucket = aws_s3_bucket.cf_templates.id
  key    = "template.json"
  source = "${path.module}/sc-templates/template.json"
  etag = filemd5("${path.module}/sc-templates/template.json")
}

resource "aws_s3_bucket_object" "init-repo" {
    for_each = fileset(local.zip_output_path, "*")
    key = "repositories/${each.value}"
    bucket = aws_s3_bucket.cf_templates.id
    source = "${local.zip_output_path}/${each.value}"
}

resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = "DevOps"
  description   = "Products homologated by DevOps"
  provider_name = "DevOps"
}

resource "aws_servicecatalog_product" "codecommit" {
  name  = "Codecommit Repository"
  owner = "DevOps"
  type  = "CLOUD_FORMATION_TEMPLATE"

  provisioning_artifact_parameters {
    template_url = "https://s3.amazonaws.com/${aws_s3_bucket.cf_templates.id}/${aws_s3_bucket_object.template.id}"
    name = "v0.3"
    type = "CLOUD_FORMATION_TEMPLATE"
    description = "v0.3"
  }
}



