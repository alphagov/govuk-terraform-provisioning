
resource "aws_iam_group_membership" "publishing_platform" {
    name = "publishing_platform-group-membership"
    users = [ 
        "${aws_iam_user.danielroseman.name}",
        "${aws_iam_user.kevindew.name}"
    ]
    group = "${aws_iam_group.publishing_platform.name}"
}
