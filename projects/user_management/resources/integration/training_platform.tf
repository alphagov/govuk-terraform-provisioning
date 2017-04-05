
resource "aws_iam_group_membership" "training_platform" {
    name = "training_platform-group-membership"
    users = [ 
        "${aws_iam_user.grahampengelly.name}",
        "${aws_iam_user.rubenarakelyan.name}"
    ]
    group = "${aws_iam_group.training_platform.name}"
}
