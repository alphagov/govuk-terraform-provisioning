resource "aws_iam_user" "asset-manager" {
  name = "${var.bucket_name}-${var.environment}-user"
}

resource "aws_iam_policy_attachment" "asset-manager" {
  name = "asset-manager-user-iam-policy-attachment"
  users = ["${aws_iam_user.asset-manager.name}"]
  policy_arn = "${aws_iam_policy.asset-manager.arn}"
}
