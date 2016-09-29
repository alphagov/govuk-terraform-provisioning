variable "bucket_name" {
  type = "string"
  default = "govuk-elasticsearch"
}

variable "team" {
  type = "string"
  default = "Infrastructure"
}

variable "username" {
  type = "string"
  default = "govuk-elasticsearch"
}

variable "versioning" {
  type = "string"
  default = "true"
}


resource "template_file" "readwrite_policy_file" {
  template = "${file("projects/elasticsearch_s3_snapshots/resources/templates/readwrite_policy.tpl")}"

  vars {
    bucket_name = "${var.bucket_name}"
    environment = "${var.environment}"
  }
}

resource "aws_s3_bucket" "govuk-elasticsearch" {
  bucket = "${var.bucket_name}-${var.environment}"

  tags {
    Environment = "${var.environment}"
    Team = "${var.team}"
  }

  versioning {
    enabled = "${var.versioning}"
  }

  lifecycle_rule {
    prefix = ""
    enabled = true

    expiration {
      days = 30
    }

    noncurrent_version_expiration {
      days = 60
    }

  }
}

resource "aws_s3_bucket" "govuk-elasticsearch-logs" {
  bucket = "${var.bucket_name}-logs-${var.environment}"

  tags {
    Environment = "${var.environment}"
    Team = "${var.team}"
  }

  versioning {
    enabled = "${var.versioning}"
  }

  lifecycle_rule {
    prefix = ""
    enabled = true

    expiration {
      days = 30
    }

    noncurrent_version_expiration {
      days = 60
    }

  }
}

resource "aws_iam_policy" "readwrite_policy" {
  name = "${var.bucket_name}_${var.username}-policy"
  description = "${var.bucket_name} allow writes"
  policy = "${template_file.readwrite_policy_file.rendered}"
}

resource "aws_iam_user" "iam_user" {
  name = "${var.username}"
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name = "${var.bucket_name}_${var.username}_attachment_policy"
  users = ["${aws_iam_user.iam_user.name}"]
  policy_arn = "${aws_iam_policy.readwrite_policy.arn}"
}
