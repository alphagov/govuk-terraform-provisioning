resource "aws_s3_bucket" "asset-manager" {
  bucket = "${var.bucket_name}-${var.environment}"
  acl = "public-read"
}
