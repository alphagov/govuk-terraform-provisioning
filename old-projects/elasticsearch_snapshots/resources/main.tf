module "paired_user" {
    source = "../../../modules/paired_user"

    bucket_name = "govuk-api-elasticsearch-snapshots"
    environment = "${var.environment}"
    team        = "Finding Things"
    username    = "govuk-api-elasticsearch-snapshots"
}
