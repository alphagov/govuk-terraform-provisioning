resource "aws_s3_bucket" "asset-manager" {
  bucket = "${var.bucket_name}-${var.environment}"
  acl = "private"
}

resource "aws_s3_bucket_policy" "asset-manager-env-sync-bucket" {
  bucket = "${aws_s3_bucket.asset-manager.id}"
  policy = "${data.aws_iam_policy_document.asset-manager-env-sync-bucket.json}"
}
