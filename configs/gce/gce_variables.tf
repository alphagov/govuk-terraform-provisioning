variable "gce_default_region" {
  description = "Default GCE region"
  type = "string"
  default = "europe-west1-b"
}

# FIXME this should probably be set by the specific project
variable "gce_project" {
  description = "GCE project to work on"
  type = "string"
  default = "govuk-test"
}

provider "google" {
  project = "${var.gce_project}"
  region = "${var.gce_default_region}"
}
