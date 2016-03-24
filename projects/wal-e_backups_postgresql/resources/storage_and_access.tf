module "paired_user" {
    source = "../../../modules/paired_user"

    bucket_name = "govuk-wal-e_backups_postgresql"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-wal-e_backups_postgresql"
}
