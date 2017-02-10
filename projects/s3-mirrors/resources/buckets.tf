resource "aws_s3_bucket" "govuk_mirror" {
  bucket = "govuk-mirror-${var.environment}"

  tags {
    Environment = "${var.environment}"
    Team = "Infrastructure"
  }

  versioning {
    enabled = true
  }
}
