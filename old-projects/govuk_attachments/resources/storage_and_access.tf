module "private_s3_bucket" {
    source = "../../../modules/private_s3_bucket"

    bucket_name = "govuk-attachments"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-attachments"
    versioning  = "true"
}
