module "private_s3_bucket" {
    source = "../../../modules/private_s3_bucket"

    bucket_name = "govuk-transition-logs"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-transition-logs"
}
