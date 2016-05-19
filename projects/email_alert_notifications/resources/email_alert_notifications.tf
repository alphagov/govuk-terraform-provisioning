variable "s3_bucket_name" {
  default = "govuk-email-alert-notifications"
}

variable "environment"{
}

variable "rename_email_files_with_request_id_version"{
}

variable "lambda_bucket"{
  default = "govuk-lambda-applications"
}

resource "template_file" "s3_bucket_policy" {
  template = "${file("templates/email_alert_s3_bucket_policy.json")}"
  vars {
    account_id = "${element(split(":", aws_iam_role.lambda_execute_and_write_to_email_alert_bucket.arn), 4)}"
    bucket_name = "${var.s3_bucket_name}-${var.environment}"
    lambda_role = "${aws_iam_role.lambda_execute_and_write_to_email_alert_bucket.arn}"
  }
}

resource "template_file" "put_and_delete_to_email_alert_bucket_policy" {
  template = "${file("templates/put_and_delete_to_s3_policy.json")}"
  vars {
    resource_arn = "${aws_s3_bucket.email_alert_inbox_bucket.arn}"
  }
}

resource "aws_s3_bucket" "email_alert_inbox_bucket" {
  bucket = "${var.s3_bucket_name}-${var.environment}"
  acl = "public-read"
  policy = "${template_file.s3_bucket_policy.rendered}"
}

resource "aws_iam_role" "lambda_execute_and_write_to_email_alert_bucket" {
  name = "lambda_execute_and_write_to_email_alert_bucket"
  assume_role_policy = "${file("templates/lambda_assume_role_policy.json")}"
}

resource "aws_iam_role_policy" "put_and_delete_to_email_alert_bucket" {
  name = "put_and_delete_to_email_alert_bucket"
  role = "${aws_iam_role.lambda_execute_and_write_to_email_alert_bucket.id}"
  policy = "${template_file.put_and_delete_to_email_alert_bucket_policy.rendered}"
}

resource "aws_iam_role_policy" "write_to_logs" {
  name = "write_to_logs"
  role = "${aws_iam_role.lambda_execute_and_write_to_email_alert_bucket.id}"
  policy = "${file("templates/write_to_logs_policy.json")}"
}

resource "aws_lambda_function" "rename_email_files_with_request_id"{
  s3_bucket = "${var.lambda_bucket}-${var.environment}"
  s3_key="rename_email_files_with_request_id.zip"
  s3_object_version="${var.rename_email_files_with_request_id_version}"
  function_name = "rename_email_files_with_request_id"
  role = "${aws_iam_role.lambda_execute_and_write_to_email_alert_bucket.arn}"
  handler = "rename_email_files_with_request_id.lambda_handler"
  runtime = "python2.7"
}

resource "aws_lambda_permission" "allow_email_alert_inbox_bucket" {
    statement_id = "AllowExecutionFromS3Bucket"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.rename_email_files_with_request_id.arn}"
    principal = "s3.amazonaws.com"
    source_arn = "${aws_s3_bucket.email_alert_inbox_bucket.arn}"
}

resource "aws_s3_bucket_notification" "email_alert_inbox_bucket_notification" {
    bucket = "${aws_s3_bucket.email_alert_inbox_bucket.id}"
    lambda_function {
      lambda_function_arn = "${aws_lambda_function.rename_email_files_with_request_id.arn}"
      events = ["s3:ObjectCreated:Put"]
    }
}
