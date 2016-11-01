resource "aws_iam_user" "env_sync_staging" {
    name = "govuk-mysql-xtrabackups-env-sync-to-staging"
}

resource "aws_iam_user" "env_sync_integration" {
    name = "govuk-mysql-xtrabackups-env-sync-to-integration"
}

resource "aws_iam_policy" "env_sync_policy" {
    name = "govuk-mysql-xtrabackups_env-sync-policy"
    description = "Allows read-only access to Production bucket for environment sync"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::govuk-mysql-xtrabackups-${var.environment}"
    },
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::govuk-mysql-xtrabackups-${var.environment}/*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "env_sync_policy_attachment" {
    name = "env_sync_policy_attachment"
    users = [
        "${aws_iam_user.env_sync_staging.name}",
        "${aws_iam_user.env_sync_integration.name}",
    ]
    policy_arn = "${aws_iam_policy.env_sync_policy.arn}"
}
