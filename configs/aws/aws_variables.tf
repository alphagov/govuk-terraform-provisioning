variable "aws_default_region" {
  description = "Default AWS region"
  type = "string"
  default = "eu-west-1"
}

provider "aws" {
  region = "${var.aws_default_region}"
}
