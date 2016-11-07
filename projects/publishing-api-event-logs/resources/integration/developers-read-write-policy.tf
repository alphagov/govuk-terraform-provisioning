
data "template_file" "developer_readwrite" {
  # FIXME: use less fixed paths
  template = "${file("projects/publishing-api-event-logs/resources/templates/read_write_user.tpl")}"

  vars {
    bucket_name = "${var.bucket_name}"
    environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "developer_readwrite" {
    name = "${var.bucket_name}_developer_readwrite_policy"
    description = "${var.bucket_name} allows developer read / write access"
    policy = "${data.template_file.developer_readwrite.rendered}"
}

resource "aws_iam_policy_attachment" "publishing_api_event_log_developer_readwrite_attachment" {
    name = "${var.bucket_name}_developer_readwrite_attachment_policy"
    groups = ["publishing_platform"]
    policy_arn = "${aws_iam_policy.developer_readwrite.arn}"
}
