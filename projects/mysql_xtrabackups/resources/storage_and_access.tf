module "paired_user" {
    source = "../../../modules/paired_user"

    bucket_name = "govuk-mysql-xtrabackups"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-mysql-xtrabackups"
}
