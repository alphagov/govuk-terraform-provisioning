resource "aws_s3_bucket" "govuk-offsite-assets-manager" {
  bucket = "${var.bucket_name}-manager-${var.environment}"

  tags {
    Environment = "${var.environment}"
    Team = "${var.team}"
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    prefix = ""
    enabled = true

    expiration {
      days = 1
    }

    noncurrent_version_transition {
      days = 30
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket" "govuk-offsite-assets-whitehall" {
  bucket = "${var.bucket_name}-whitehall-${var.environment}"

  tags {
    Environment = "${var.environment}"
    Team = "${var.team}"
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    prefix = ""
    enabled = true

    expiration {
      days = 1
    }

    noncurrent_version_transition {
      days = 30
      storage_class = "STANDARD_IA"
    }
  }
}

data "template_file" "read_write_user" {
  template = "${file("projects/datastore-offsite-assets/resources/templates/read_write_user.tpl")}"

  vars {
    bucket_name = "${var.bucket_name}"
    environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "read_write_user" {
  name = "${var.bucket_name}"
  policy = "${data.template_file.read_write_user.rendered}"
}

resource "aws_iam_policy_attachment" "govuk-offsite-assets" {
  name = "govuk_offsite_assets_attachment_policy"
  users = ["${aws_iam_user.iam_user.name}"]
  policy_arn = "${aws_iam_policy.read_write_user.arn}"
}

resource "aws_iam_user" "iam_user" {
  name = "${var.username}"
}
