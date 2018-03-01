resource "aws_iam_user" "static-assets-user" {
    name = "${var.bucket_name}_user"
}

data "template_file" "static_assets_automated_read_write" {
    template = "${file("projects/static_assets/resources/templates/read_write_user.tpl")}"

    vars {
        bucket_name = "${var.bucket_name}"
        environment = "${var.environment}"
    }
}

resource "aws_iam_policy" "static_assets_automated_read_write" {
    name = "${var.bucket_name}_user_policy"
    description = "${var.bucket_name} allows read/write"
    policy = "${data.template_file.static_assets_automated_read_write.rendered}"
}

resource "aws_iam_policy_attachment" "static_assets_attachment" {
    name = "${var.bucket_name}_user_attachment_policy"
    users = ["${aws_iam_user.static-assets-user.name}"]
    policy_arn = "${aws_iam_policy.static_assets_automated_read_write.arn}"
}
