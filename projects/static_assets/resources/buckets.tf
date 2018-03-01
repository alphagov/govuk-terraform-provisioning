resource "aws_s3_bucket" "static_assets" {
    bucket = "${var.bucket_name}-${var.environment}"
    acl = "public-read"
}
