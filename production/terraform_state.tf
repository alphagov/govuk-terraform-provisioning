variable "terraform_state_bucket_name" {
    type = "string"
    default = "govuk-terraform-state"
}

resource "aws_s3_bucket" "terraform_state_bucket" {
    acl = "private"
    bucket = "${var.terraform_state_bucket_name}"
    tags {
        Environment = "Production"
        Team = "Infrastructure"
    }
}

resource "terraform_remote_state" "govuk_terraform_remote_state" {
    backend = "s3"
    config {
        acl = "private"
        bucket = "${var.terraform_state_bucket_name}"
        encrypt = true
        key = "terraform.tfstate"
        region = "eu-west-1"
    }
}
