variable "s3_bucket" {
  default = "govuk-analytics-logs-production"
}

variable "s3_bucket_id" {
  default = "arn:aws:s3:::govuk-analytics-logs-production"
}
variable "public_api_logs_prefix" {
  default = "public_api_logs/"
}
variable "public_api_logs_suffix" {
  default = ".log.gz"
}
variable "lambda_function_name" {
  default = "SendPublicApiEventsToGA"
}
variable "lambda_artefact_name" {
  default = "send_public_api_events_to_ga_lambda.zip"
}
variable "lambda_handler" {
  default = "send_public_api_events_to_ga.handle_lambda"
}
variable "lambda_runtime" {
  default = "python3.6"
}
variable "lambda_timeout" {
  default = 30
}
