module "mongodb_s3_backup" {
    source = "../../../modules/private_s3_bucket"

    bucket_name = "govuk-mongodb-backup-s3"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-mongodb-backup-s3"
}

module "mongodb_s3_daily_backpup" {
    source = "../../../modules/private_s3_bucket"

    bucket_name = "govuk-mongodb-daily-backup-s3"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-mongodb-daily-backup-s3"
}

