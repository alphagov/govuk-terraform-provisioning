resource "aws_iam_user" "publishing-api-event-log-user" {
    name = "${var.bucket_name}_user"
}

data "template_file" "automated_read_write" {
  # FIXME: use less fixed paths
  template = "${file("projects/publishing-api-event-logs/resources/templates/read_write_user.tpl")}"

  vars {
    bucket_name = "${var.bucket_name}"
    environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "automated_read_write" {
    name = "${var.bucket_name}_user_policy"
    description = "${var.bucket_name} allows read/write"
    policy = "${data.template_file.automated_read_write.rendered}"
}

resource "aws_iam_policy_attachment" "publishing_api_event_log_attachment" {
    name = "${var.bucket_name}_user_attachment_policy"
    users = ["${aws_iam_user.publishing-api-event-log-user.name}"]
    policy_arn = "${aws_iam_policy.automated_read_write.arn}"
}
