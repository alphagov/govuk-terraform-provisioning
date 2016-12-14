resource "aws_iam_user" "developer-docs-user" {
    name = "${var.bucket_name}_user"
}

data "template_file" "developer_docs_automated_read_write" {
    template = "${file("projects/developer_docs/resources/templates/read_write_user.tpl")}"

    vars {
        bucket_name = "${var.bucket_name}"
        environment = "${var.environment}"
        owner = "Finding Things"
    }
}

resource "aws_iam_policy" "developer_docs_automated_read_write" {
    name = "${var.bucket_name}_user_policy"
    description = "${var.bucket_name} allows read/write"
    policy = "${data.template_file.developer_docs_automated_read_write.rendered}"
}

resource "aws_iam_policy_attachment" "developer_docs_attachment" {
    name = "${var.bucket_name}_user_attachment_policy"
    users = ["${aws_iam_user.developer-docs-user.name}"]
    policy_arn = "${aws_iam_policy.developer_docs_automated_read_write.arn}"
}
