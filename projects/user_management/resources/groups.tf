#
# New groups should be added here.
#   In alphabetical order.
#

resource "aws_iam_group" "custom_formats" {
    name = "custom_formats"
    path = "/group/"
}

resource "aws_iam_group" "publishing_platform" {
    name = "publishing_platform"
    path = "/group/"
}
