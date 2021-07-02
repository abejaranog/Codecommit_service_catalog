# Codecommit_service_catalog
Service catalog that contains codecommit product to create repositories with events on-demand

## Pre-requisites

- Install Terraform version 0.13.0 or newer and Terragrunt version v0.25.1 or newer.

- Update the bucket parameter in the root terragrunt.hcl. We use S3 as a Terraform backend to store your Terraform state, and S3 bucket names must be globally unique. The name currently in the file is already taken, so you'll have to specify your own. Alternatives, you can set the environment variable TG_BUCKET_PREFIX to set a custom prefix.

- Configure your AWS credentials using one of the supported authentication mechanisms.

## Usage

To create backend.tf and provider.tf files you must run
```
terragrunt init
```

After that, you can use terragrunt as terraform command like:
```
terragrunt plan
```

## Layout

- _init-repo_ folder contains files that initializes the codecommit repository.
- _sc-templates_ contains the service catalog templates that creates the product
- _output_ folder contains zip package of repositories to upload to S3 and deploys on codecommit

