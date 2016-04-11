module "paired_user" {
    source = "../../../modules/paired_user"

    bucket_name = "govuk-mongodb-backup-s3"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-mongodb-backup-s3"
}
