data "aws_iam_policy_document" "asset-manager-env-sync-user" {
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-production"
    ]
  }

  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-production/*"
    ]
  }

  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-integration",
      "arn:aws:s3:::${var.bucket_name}-staging"
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-integration/*",
      "arn:aws:s3:::${var.bucket_name}-staging/*"
    ]
  }
}

resource "aws_iam_policy" "asset-manager-env-sync-user" {
  name = "asset-manager-env-sync-user-policy"
  path = "/"
  policy = "${data.aws_iam_policy_document.asset-manager-env-sync-user.json}"
}
