variable "bucket_name" {
    type = "string"
}

variable "environment" {
    type = "string"
}

variable "team" {
    type = "string"
}

variable "username" {
    type = "string"
}

variable "versioning" {
    type = "string"
    default = "false"
}

variable "lifecycle" {
    type = "string"
    default = "false"
}


resource "template_file" "readwrite_policy_file" {
  template = "${file("${path.module}/templates/readwrite_policy.tpl")}"

  vars {
    bucket_name = "${var.bucket_name}"
    environment = "${var.environment}"
  }
}



resource "aws_s3_bucket" "bucket" {
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
        enabled = "${var.lifecycle}"

        transition {
            days = 30
            storage_class = "STANDARD_IA"
        }
        transition {
            days = 60
            storage_class = "GLACIER"
        }
        expiration {
            days = 90
        }
    }
}



resource "aws_iam_policy" "readwrite_policy" {
    name = "${var.bucket_name}_${var.username}-policy"
    description = "${var.bucket_name} allows writes"
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
