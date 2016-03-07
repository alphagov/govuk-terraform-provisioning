variable "uktt_data_bucket_name" {
    type = "string"
    default = "govuk-uktt-data"
}

resource "aws_s3_bucket" "uktt_data_bucket" {
    acl = "private"
    bucket = "${var.uktt_data_bucket_name}-${var.environment}"
    versioning {
      enabled = true
    }
    tags {
        Environment = "${var.environment}"
        Team = "Infrastructure"
    }
}
