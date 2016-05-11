resource "aws_iam_user" "env_sync" {
    name = "govuk-transition-postgresql-env-sync"
}


resource "aws_iam_user_policy" "env-sync-policy" {
    name = "govuk-wal-e-backups-transition-postgresql_env-sync-policy"
    user = "${aws_iam_user.env_sync.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::govuk-wal-e-backups-transition-postgresql-${var.environment}"
    },
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::govuk-wal-e-backups-transition-postgresql-${var.environment}/*"
    }
  ]
}
EOF
}
