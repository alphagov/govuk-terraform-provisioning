
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

resource "aws_iam_policy" "ami_builder_policy" {
    name = "ami-builder-policy"
    description = "ami_builder_policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
      "Effect": "Allow",
      "Action" : [
        "ec2:AttachVolume",
        "ec2:CreateVolume",
        "ec2:DeleteVolume",
        "ec2:CreateKeypair",
        "ec2:DeleteKeypair",
        "ec2:DescribeSubnets",
        "ec2:CreateSecurityGroup",
        "ec2:DeleteSecurityGroup",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CreateImage",
        "ec2:CopyImage",
        "ec2:RunInstances",
        "ec2:TerminateInstances",
        "ec2:StopInstances",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume",
        "ec2:DescribeInstances",
        "ec2:CreateSnapshot",
        "ec2:DeleteSnapshot",
        "ec2:DescribeSnapshots",
        "ec2:DescribeImages",
        "ec2:RegisterImage",
        "ec2:CreateTags",
        "ec2:ModifyImageAttribute"
      ],
      "Resource" : "*"
  }]
}
EOF
}

resource "aws_iam_policy_attachment" "ami_builder_attachment" {
    name = "ami_builder_policy"
    groups = ["${aws_iam_group.ami_builders_group.name}"]
    policy_arn = "${aws_iam_policy.ami_builder_policy.arn}"
}
