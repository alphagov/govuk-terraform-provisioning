resource "aws_iam_role" "asset-manager-backup" {
  name = "asset-manager-backup-iam-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "asset-manager-backup" {
  name       = "asset-manager-backup-iam-policy-attachment"
  roles      = ["${aws_iam_role.asset-manager-backup.name}"]
  policy_arn = "${aws_iam_policy.asset-manager-backup.arn}"
}
