data "aws_iam_policy_document" "asset-manager" {
  statement {
    sid = "1"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-${var.environment}/*"
    ]
  }

  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-${var.environment}"
    ]
  }
}

resource "aws_iam_policy" "asset-manager" {
  name = "asset-manager-user-iam-policy"
  path = "/"
  policy = "${data.aws_iam_policy_document.asset-manager.json}"
}
