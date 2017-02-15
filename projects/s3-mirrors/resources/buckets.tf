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

resource "aws_s3_bucket_policy" "govuk_mirror_fastly_policy" {
    bucket = "${aws_s3_bucket.govuk_mirror.id}"
    policy = "${data.aws_iam_policy_document.s3_mirror_fastly_read_policy_doc.json}"
}
