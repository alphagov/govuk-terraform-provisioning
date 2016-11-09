resource "aws_s3_bucket" "custom_formats_mapit" {
    bucket = "${var.bucket_name}-${var.environment}"

    tags {
        Environment = "${var.environment}"
        Team = "custom_formats"
    }
}
