module "paired_user" {
    source = "../../../../modules/paired_user"

    bucket_name = "govuk-dev-boxes"
    environment = "test"
    team        = "Infrastructure"
    username    = "govuk-dev-box-uploader"
}
