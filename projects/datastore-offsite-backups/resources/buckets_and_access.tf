resource "aws_s3_bucket" "govuk-offsite-backups" {
  bucket = "${var.bucket_name}-${var.environment}"

  tags {
    Environment = "${var.environment}"
    Team = "${var.team}"
  }

}

data "template_file" "read_write_user" {
  template = "${file("projects/datastore-offsite-backups/resources/templates/read_write_user.tpl")}"

  vars {
    bucket_name = "${var.bucket_name}"
    environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "read_write_user" {
  name = "${var.bucket_name}"
  policy = "${data.template_file.read_write_user.rendered}"
}

resource "aws_iam_policy_attachment" "govuk-offsite-backups" {
  name = "${var.bucket_name}_govuk_offsite_backups_attachment_polocy"
  users = ["${aws_iam_user.iam_user.name}"]
  policy_arn = "${aws_iam_policy.read_write_user.arn}"
}

resource "aws_iam_user" "iam_user" {
  name = "${var.username}"
}
