resource "aws_iam_user" "env_sync" {
    name = "govuk-attachments-env-sync"
}


resource "aws_iam_user_policy" "env-sync-policy" {
    name = "govuk-attachments_env-sync-policy"
    user = "${aws_iam_user.env_sync.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::govuk-attachments-${var.environment}"
    },
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::govuk-attachments-${var.environment}/*"
    }
  ]
}
EOF
}
