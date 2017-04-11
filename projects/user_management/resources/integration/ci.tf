
resource "aws_iam_group_membership" "ci" {
    name = "ci-group-membership"
    users = [ 
        "${aws_iam_user.govuk-ci.name}",
    ]
    group = "${aws_iam_group.ci.name}"
}
