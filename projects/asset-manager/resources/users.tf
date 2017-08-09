resource "aws_iam_user" "asset-manager" {
  name = "${var.bucket_name}-${var.environment}-user"
}

data "aws_iam_policy_document" "asset-manager" {
  statement {
    sid = "1"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}-${var.environment}/*"
    ]
  }
}

resource "aws_iam_policy" "asset-manager" {
  name = "asset-manager-user-iam-policy"
  path = "/"
  policy = "${data.aws_iam_policy_document.asset-manager.json}"
}

resource "aws_iam_policy_attachment" "asset-manager" {
  name = "asset-manager-user-iam-policy-attachment"
  users = ["${aws_iam_user.asset-manager.name}"]
  policy_arn = "${aws_iam_policy.asset-manager.arn}"
}
