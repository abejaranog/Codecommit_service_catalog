variable "AWS_account" {
  type        = string
  description = "AWS Account to be deployed the stack in"
}

variable "AWS_region" {
  type        = string
  description = "AWS Region"
  default     = "us-west-2"
}

locals {
  zip_output_path = "${path.module}/output"
}