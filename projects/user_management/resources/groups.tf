#
# New groups should be added here.
#   In alphabetical order.
#

resource "aws_iam_group" "custom_formats" {
    name = "custom_formats"
    path = "/groups/"
}

resource "aws_iam_group" "publishing_platform" {
    name = "publishing_platform"
    path = "/groups/"
}

resource "aws_iam_group" "training_platform" {
    name = "training_platform"
    path = "/groups/"
}

resource "aws_iam_group" "infrastructure_team" {
    name = "infrastructure_team"
    path = "/groups/"
}

resource "aws_iam_group" "ci" {
    name = "ci"
    path = "/groups/"
}

resource "aws_iam_policy_attachment" "base-user-console-access_user_attachment" {
    name = "base-user-console-access_user_attachment_policy"
    groups = [
      "${aws_iam_group.custom_formats.name}",
      "${aws_iam_group.publishing_platform.name}",
      "${aws_iam_group.training_platform.name}"
    ]
    policy_arn = "${aws_iam_policy.base-user-console-access.arn}"
}

resource "aws_iam_policy" "infrastructure_team_policy" {
    name = "infrastructure_team_policy"
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

resource "aws_iam_policy_attachment" "infrastructure_team_attachment" {
    name = "infrastructure_team_policy_attachment"
    groups = ["${aws_iam_group.infrastructure_team.name}"]
    policy_arn = "${aws_iam_policy.infrastructure_team_policy.arn}"
}


# get the current aws account_id
data "aws_caller_identity" "current" { }


data "template_file" "base-user-console-access" {
  # FIXME: use less fixed paths
  template = "${file("projects/user_management/resources/templates/base-user-console-access.tpl")}"

  vars {
    account_id  = "${data.aws_caller_identity.current.account_id}"
    environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "base-user-console-access" {
    name = "base-user-console-access_user_policy"
    description = "base-user-console-access allows standard user tasks like create access key"
    policy = "${data.template_file.base-user-console-access.rendered}"
}

resource "aws_iam_policy" "ci_policy" {
    name = "ci_policy"
    description = "CI policy: launch instances, manage DNS entries"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:*",
                "iam:AddRoleToInstanceProfile",
                "iam:PassRole",
                "route53:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [ "s3:*" ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::govuk-terraform-state-integration",
                "arn:aws:s3:::govuk-terraform-state-integration/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "ci_attachment" {
    name = "ci_policy_attachment"
    groups = ["${aws_iam_group.ci.name}"]
    policy_arn = "${aws_iam_policy.ci_policy.arn}"
}

