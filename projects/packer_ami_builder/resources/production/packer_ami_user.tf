resource "aws_iam_group" "ami_builders_group" {
    name = "ami-builders"
    path = "/machine-users/"
}

resource "aws_iam_user" "packer_ami_builder_user" {
    name = "packer-ami-builder"
}

resource "aws_iam_group_membership" "ami_builders_membership" {
    name = "ami-builders-membership"
    users = [
        "${aws_iam_user.packer_ami_builder_user.name}",
    ]
    group = "${aws_iam_group.ami_builders_group.name}"
}

resource "template_file" "ami_building_policy_template" {
    # FIXME: use less fixed paths
    template = "${file("projects/packer_ami_builder/resources/production/templates/ami_building_policy.tpl")}"

    vars {
        account_id = "${var.account_id}"
        region     = "${var.aws_default_region}"
        vpc_id     = "${aws_vpc.ami_builder_vpc.id}"
    }
}

resource "aws_iam_policy" "ami_builder_policy" {
    name = "ami-builder-policy"
    description = "ami_builder_policy"
    policy = "${template_file.ami_building_policy_template.rendered}"
}

resource "aws_iam_policy_attachment" "ami_builder_attachment" {
    name = "ami_builder_policy"
    groups = ["${aws_iam_group.ami_builders_group.name}"]
    policy_arn = "${aws_iam_policy.ami_builder_policy.arn}"
}

resource "aws_iam_instance_profile" "ami_builder_profile" {
    name = "VPCLockDown"
    roles = ["${aws_iam_role.ami_builder_role.name}"]
}

resource "aws_iam_role" "ami_builder_role" {
    # See: https://blogs.aws.amazon.com/security/post/Tx1ZU3LW4LLPQY2/How-to-Help-Lock-Down-a-User-s-Amazon-EC2-Capabilities-to-a-Single-VPC
    name = "VPCLockDown"
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
