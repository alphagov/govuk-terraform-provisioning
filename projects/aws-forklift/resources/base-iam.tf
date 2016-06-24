resource "aws_iam_instance_profile" "base_profile" {
    name  = "base_profile"
    roles = ["${aws_iam_role_policy.base_role.name}"]
}

resource "aws_iam_role_policy" "base_role" {
    name = "base_role"
    role = "${aws_iam_role.base_role.id}"
    policy = "${file("projects/aws-forklift/resources/files/assume-role-policy.json")}"
}


resource "aws_iam_role" "base_role" {
    name = "base_role"
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
