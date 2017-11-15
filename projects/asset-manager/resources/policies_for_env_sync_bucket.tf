data "aws_iam_policy_document" "asset-manager-env-sync-bucket" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-${var.environment}"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.production_aws_account_id}:user/${var.bucket_name}-production-env-sync-user",
      ]
    }
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject",
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-${var.environment}/*"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.production_aws_account_id}:user/${var.bucket_name}-production-env-sync-user",
      ]
    }
  }
}
