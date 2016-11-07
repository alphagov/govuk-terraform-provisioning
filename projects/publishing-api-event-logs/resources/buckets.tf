resource "aws_s3_bucket" "publishing_api_event_log" {
    bucket = "${var.bucket_name}-${var.environment}"

    tags {
        Environment = "${var.environment}"
        Team = "publishing_platform"
    }
}
