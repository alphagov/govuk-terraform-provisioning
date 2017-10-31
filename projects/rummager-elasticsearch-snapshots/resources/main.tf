module "rummager-elasticsearch-snapshots" {
    source = "../../../modules/private_s3_bucket"

    bucket_name  = "govuk-rummager-elasticsearch-snapshots"
    environment  = "${var.environment}"
    team         = "Infrastructure"
    username     = "govuk-rummager-elasticsearch-snapshots"
    versioning   = "true"
    lifecycle    = "true"
    days_to_keep = 7
}
