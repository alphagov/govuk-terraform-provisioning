resource "aws_iam_user" "asset-manager-env-sync" {
  name = "${var.bucket_name}-${var.environment}-env-sync-user"
}

resource "aws_iam_policy_attachment" "asset-manager-env-sync" {
  name = "asset-manager-env-sync-iam-policy-attachment"
  users = ["${aws_iam_user.asset-manager-env-sync.name}"]
  policy_arn = "${aws_iam_policy.asset-manager-env-sync-user.arn}"
}
