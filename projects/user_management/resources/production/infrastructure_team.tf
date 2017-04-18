resource "aws_iam_group_membership" "infrastructure_team" {
    name = "infrastructure_team-group-membership"
    users = [
        "${aws_iam_user.anafernandez.name}",
        "${aws_iam_user.samcook.name}",
        "${aws_iam_user.stephenharker.name}",
    ]
    group = "${aws_iam_group.infrastructure_team.name}"
}
