variable "bucket_name" {
  type    = "string"
  default = "govuk-assets"
}

variable "aws_region_for_backups" {
  type    = "string"
  default = "eu-west-2"
}

variable "production_aws_account_id" {
  type = "string"
  description = "AWS account ID for production environment"
}
