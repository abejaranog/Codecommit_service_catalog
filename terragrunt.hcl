remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "test-tfstate-abg"
    key            = "devops/service_catalog.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "tfstate-lock-test"
  }

}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "us-west-2"  
}

provider "archive" {}
EOF
}