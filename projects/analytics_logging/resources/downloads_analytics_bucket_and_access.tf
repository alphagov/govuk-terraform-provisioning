resource "aws_s3_bucket" "downloads-analytics-logs" {
  bucket = "downloads-analytics-logs-${var.environment}"

  tags {
    Environment = "${var.environment}"
    Team = "Performance"
  }
}

data "aws_iam_policy_document" "read_write_policy_document" {
  statement {
    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.downloads-analytics-logs.arn}"
    ]
  }
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.downloads-analytics-logs.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "fastly_policy" {
  name = "downloads-analytics-logs_fastly_policy"
  policy = "${data.aws_iam_policy_document.read_write_policy_document.json}"
}

resource "aws_iam_policy_attachment" "fastly_user_policy_attachment" {
  name = "downloads-analytics-logs_fastly_policy_attachment"
  users = ["${aws_iam_user.fastly_user.name}"]
  policy_arn = "${aws_iam_policy.fastly_policy.arn}"
}

resource "aws_iam_user" "fastly_user" {
  name = "downloads-analytics-logs-fastly"
}
