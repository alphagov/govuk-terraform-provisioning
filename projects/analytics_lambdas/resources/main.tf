# IAM Role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "send_public_api_events_to_ga_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
data "aws_iam_policy_document" "s3-access-ro" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

resource "aws_iam_policy" "s3-access-ro" {
  name = "s3-access-ro"
  path = "/"
  policy = "${data.aws_iam_policy_document.s3-access-ro.json}"
}

resource "aws_iam_role_policy_attachment" "s3-access-ro" {
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.s3-access-ro.arn}"
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.func.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${var.s3_bucket_id}"
}

# AWS Lambda function
resource "aws_lambda_function" "func" {
  s3_bucket = "${var.s3_bucket}"
  s3_key = "${var.lambda_artefact_name}"
  function_name = "${var.lambda_function_name}"
  role = "${aws_iam_role.lambda_role.arn}"
  handler = "${var.lambda_handler}"
  runtime = "${var.lambda_runtime}"
  timeout = "${var.lambda_timeout}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${var.s3_bucket_id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.func.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "${var.public_api_logs_prefix}"
    filter_suffix       = "${var.public_api_logs_suffix}"
  }
}
