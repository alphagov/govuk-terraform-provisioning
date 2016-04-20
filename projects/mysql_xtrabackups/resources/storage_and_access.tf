module "private_s3_bucket" {
    source = "../../../modules/private_s3_bucket"

    bucket_name = "govuk-mysql-xtrabackups"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-mysql-xtrabackups"
}
