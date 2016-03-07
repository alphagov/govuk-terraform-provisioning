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
  template = "${file("templates/ami_building_policy.tpl")}"
}

resource "aws_iam_policy" "ami_builder_policy" {
    name = "ami-builder-policy"
    description = "ami_builder_policy"
    policy = "${template_file.ami_building_policy.rendered}"
}

resource "aws_iam_policy_attachment" "ami_builder_attachment" {
    name = "ami_builder_policy"
    groups = ["${aws_iam_group.ami_builders_group.name}"]
    policy_arn = "${aws_iam_policy.ami_builder_policy.arn}"
}
