provider "aws" {
  region = "${var.aws_region_for_backups}"
  alias  = "provider-for-backups"
}
