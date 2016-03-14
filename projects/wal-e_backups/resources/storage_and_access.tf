module "paired_user" {
    source = "../../../modules/paired_user"

    bucket_name = "govuk-wale-backups"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-wale-backups"
}
