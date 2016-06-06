# module "lambda_app_bucket" {
#     source = "../../../modules/private_s3_bucket"

#     bucket_name =
#     environment = "${var.environment}"
#     team        = "Infrastructure"
#     username    = "govuk-lambda-applications"
#     versioning  = "true"
# }

resource "aws_s3_bucket" "lambda_app_bucket" {
    acl = "public-read"
    bucket = "govuk-lambda-applications-${var.environment}"

    tags {
        Environment = "${var.environment}"
        Team = "Infrastructure"
    }

    versioning {
        enabled = "true"
    }
}
