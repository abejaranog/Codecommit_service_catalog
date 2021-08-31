resource "aws_s3_bucket" "cf_templates" {
    bucket = "sandbox-abg-cf-templates"
    versioning {
      enabled = true
    }
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

resource "aws_servicecatalog_principal_portfolio_association" "example" {
  portfolio_id  = aws_servicecatalog_portfolio.portfolio.id
  principal_arn = "arn:aws:iam::${var.AWS_account}:role/aws-reserved/sso.amazonaws.com/us-west-2/AWSReservedSSO_AWSAdministratorAccess_c0e97dae3dbafb4f"
}

resource "aws_servicecatalog_product" "codecommit" {
  name  = "Codecommit Repository"
  owner = "DevOps"
  type  = "CLOUD_FORMATION_TEMPLATE"

  provisioning_artifact_parameters {
    template_url = "https://s3.amazonaws.com/${aws_s3_bucket.cf_templates.id}/${aws_s3_bucket_object.template.id}"
    type = "CLOUD_FORMATION_TEMPLATE"
    name = "v0"
  }
}

resource "aws_servicecatalog_provisioning_artifact" "provisioning_artifact_v05" {
  name         = "v0.5"
  product_id   = aws_servicecatalog_product.codecommit.id
  type         = "CLOUD_FORMATION_TEMPLATE"
  template_url = "https://s3.amazonaws.com/${aws_s3_bucket.cf_templates.id}/${aws_s3_bucket_object.template.id}"
  ## BUG: Resource also needs to be renamed to update product
}

resource "aws_servicecatalog_product_portfolio_association" "association" {
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.codecommit.id
}

