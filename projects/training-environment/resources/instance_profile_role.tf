
resource "aws_iam_role_policy" "govuk-training_aws_iam_role_policy_instance" {
  name = "govuk-training-instance"
  role = "${aws_iam_role.govuk-training_aws_iam_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
     "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "govuk-training_aws_iam_role" {
  name = "govuk-training-instance"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "govuk-training_aws_iam_instance_profile" {
  name  = "govuk-training-instance"
  roles = ["${aws_iam_role.govuk-training_aws_iam_role.name}"]
}

output "govuk-training_instance_profile" {
  value = "${aws_iam_instance_profile.govuk-training_aws_iam_instance_profile.name}"
}

