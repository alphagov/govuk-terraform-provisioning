
resource "aws_iam_group_membership" "custom_formats" {
    name = "custom_formats-group-membership"
    users = [
        "${aws_iam_user.brendanbutler.name}",
        "${aws_iam_user.davidbasalla.name}",
        "${aws_iam_user.deborahchua.name}",
        "${aws_iam_user.jennyduckett.name}",
        "${aws_iam_user.simonhughesdon.name}"
    ]
    group = "${aws_iam_group.custom_formats.name}"
}
