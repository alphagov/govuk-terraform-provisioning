resource "aws_iam_policy" "require_office_ip" {
  name = "RequireOfficeIP"
  description = "Require requests to come from one of the Office IPs"
  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Deny",
    "Action": "*",
    "Resource": "*",
    "Condition": {"NotIpAddress": {"aws:SourceIp": [
      ${join(",", formatlist("\"%s\"", split(",", var.office_cidrs)))}
    ]}}
  }
}
EOT
}

resource "aws_iam_policy_attachment" "require_office_ip" {
  name = "RequireOfficeIP"
  groups = [
    "${aws_iam_group.infrastructure_group.name}",
  ]
  policy_arn = "${aws_iam_policy.require_office_ip.arn}"
}
