module "licensing_application_forms_bucket" {
    source = "../../../modules/private_s3_bucket"

    bucket_name = "govuk-licensing-application-forms"
    environment = "${var.environment}"
    team        = "Licensing"
    username    = "licensing-application-forms"
    versioning  = "true"
}
