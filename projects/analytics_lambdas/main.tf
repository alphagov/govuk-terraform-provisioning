resource "aws_s3_bucket" "bucket" {
  bucket = "${var.s3_bucket}"

  tags {
    Environment = "${var.environment}"
    Team = "Performance"
  }
}

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

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.func.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.bucket.arn}"
}

# AWS Lambda function
resource "aws_lambda_function" "func" {
    filename = "${lambda_artefact_name}"
    function_name = "${var.lambda_function_name}"
    role = "${aws_iam_role.lambda_role.arn}"
    handler = "${var.lambda_handler}"
    runtime = "${var.lambda_runtime}"
    timeout = "${var.lambda_timeout}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${aws_s3_bucket.bucket.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.func.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "${var.public_api_logs_prefix}"
    filter_suffix       = "${var.public_api_logs_suffix}"
  }
}
