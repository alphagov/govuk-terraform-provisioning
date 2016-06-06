module "lambda_app_bucket" {
    source = "../../../modules/paired_user"

    bucket_name = "govuk-lambda-applications"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-lambda-applications"
    versioning  = "true"
}
