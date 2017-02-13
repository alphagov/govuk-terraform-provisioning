resource "aws_s3_bucket" "dns_state_bucket" {
  bucket = "dns-state-bucket-${var.environment}"
  acl = "private"

  tags {
    Environment = "${var.environment}"
    Team = "Infrastructure"
  }

  versioning {
    enabled = true
  }
}
