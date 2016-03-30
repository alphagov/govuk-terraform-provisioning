variable "environment" {
  description = "Name of environment: test, integration, staging, production"
  type = "string"
}

variable "account_id" {
  description = "AWS Account ID"
}

# FIXME: this will be extracted when we have multiple providers, possibly to
# configs/<provider_name>.tf
variable "aws_default_region" {
  description = "Default AWS region"
  type = "string"
  default = "eu-west-1"
}

provider "aws" {
  region = "${var.aws_default_region}"
}
