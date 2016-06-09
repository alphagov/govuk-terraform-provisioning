module "admins" {
  source = "../../../modules/admins"
}

resource "aws_iam_policy" "require_office_ip" {
  name = "require_govuk_ip_address"
  description = "Require requests to come from one of our IPs"
  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Deny",
    "Action": "*",
    "Resource": "*",
    "Condition": {"NotIpAddress": {"aws:SourceIp": [
      ${join(",", formatlist("\"%s\"", split(",", var.office_cidrs)))},
      ${join(",", formatlist("\"%s\"", split(",", var.environment_cidrs)))}
    ]},
      "ArnNotLike": {
        "aws:SourceArn": "arn:aws:lambda:${var.aws_default_region}:${var.account_id}:*"
      }
    }
  }
}
EOT
}

resource "aws_iam_policy_attachment" "require_office_ip" {
  name = "require_govuk_ip_address"
  groups = [
    "${module.admins.group_name}",
  ]
  policy_arn = "${aws_iam_policy.require_office_ip.arn}"
}
