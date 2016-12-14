resource "aws_s3_bucket" "developer_docs" {
    bucket = "${var.bucket_name}-${var.environment}"
    acl = "public-read"

    website {
        index_document = "index.html"
        error_document = "error.html"
    }
}
