provider "aws" {
    region = "eu-west-1"
}

resource "aws_iam_group" "infrastructure_group" {
    name = "infrastructure"
    path = "/users/"
}

resource "aws_iam_user" "alexmuller_user" {
    name = "alexmuller"
}

resource "aws_iam_user" "bobwalker_user" {
    name = "bobwalker"
}

resource "aws_iam_user" "deanwilson_user" {
    name = "deanwilson"
}

resource "aws_iam_user" "mattbostock_user" {
    name = "mattbostock"
}

resource "aws_iam_group_membership" "infrastructure_membership" {
    name = "infrastructure-group-membership"
    users = [
        "${aws_iam_user.alexmuller_user.name}",
        "${aws_iam_user.bobwalker_user.name}",
        "${aws_iam_user.deanwilson_user.name}",
        "${aws_iam_user.mattbostock_user.name}",
    ]
    group = "${aws_iam_group.infrastructure_group.name}"
}

resource "aws_iam_policy" "admin_policy" {
    name = "admin-policy"
    description = "Admin policy: full access"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "admin_attachment" {
    name = "admin_policy"
    groups = ["${aws_iam_group.infrastructure_group.name}"]
    policy_arn = "${aws_iam_policy.admin_policy.arn}"
}
