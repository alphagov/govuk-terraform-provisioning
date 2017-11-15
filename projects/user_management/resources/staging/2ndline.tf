
resource "aws_iam_group_membership" "2ndline" {
    name = "2ndline-group-membership"
    users = [
        "${aws_iam_user.2ndline.name}"
    ]
    group = "${aws_iam_group.2ndline.name}"
}

