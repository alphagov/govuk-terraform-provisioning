data "aws_iam_policy_document" "asset-manager-bucket" {
  statement {
    sid = "PublicReadForGetBucketObjects"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-${var.environment}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "asset-manager" {
  bucket = "${aws_s3_bucket.asset-manager.id}"
  policy = "${data.aws_iam_policy_document.asset-manager-bucket.json}"
}
