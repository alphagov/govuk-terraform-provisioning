resource "aws_s3_bucket" "asset-manager" {
  bucket = "${var.bucket_name}-${var.environment}"
  acl = "private"

  versioning {
    enabled = true
  }

  replication_configuration {
    role = "${aws_iam_role.asset-manager-backup.arn}"

    rules {
      id     = "asset-manager-backup-replication-rule"
      prefix = ""
      status = "Enabled"

      destination {
        bucket        = "${aws_s3_bucket.asset-manager-backup.arn}"
        storage_class = "STANDARD"
      }
    }
  }
}
