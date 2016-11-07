
data "template_file" "developer_readonly" {
  # FIXME: use less fixed paths
  template = "${file("projects/publishing-api-event-logs/resources/templates/developer_readonly.tpl")}"

  vars {
    bucket_name = "${var.bucket_name}"
    environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "developer_readonly" {
    name = "${var.bucket_name}_developer_readonly_policy"
    description = "${var.bucket_name} allows developer readonly"
    policy = "${data.template_file.developer_readonly.rendered}"
}

resource "aws_iam_policy_attachment" "publishing_api_event_log_developer_readonly_attachment" {
    name = "${var.bucket_name}_developer_readonly_attachment_policy"
    groups = ["publishing_platform"]
    policy_arn = "${aws_iam_policy.developer_readonly.arn}"
}
