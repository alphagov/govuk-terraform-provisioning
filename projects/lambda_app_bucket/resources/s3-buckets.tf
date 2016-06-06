module "lambda_app_bucket" {
    source = "../../../modules/private_s3_bucket"

    bucket_name = "govuk-lambda-applications"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-lambda-applications"
    versioning  = "true"
}
