
resource "aws_iam_group_membership" "custom_formats" {
    name = "custom_formats-group-membership"
    users = [ 
        "${aws_iam_user.brendanbutler.name}",
        "${aws_iam_user.jennyduckett.name}"
    ]
    group = "${aws_iam_group.custom_formats.name}"
}
