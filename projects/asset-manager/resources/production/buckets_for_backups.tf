resource "aws_s3_bucket" "asset-manager-backup" {
  provider = "aws.provider-for-backups"
  bucket = "${var.bucket_name}-backup-${var.environment}"
  acl = "private"
  region = "${var.aws_region_for_backups}"

  versioning {
    enabled = true
  }
}
