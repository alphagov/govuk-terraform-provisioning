# Integration environment allowed IP addresses
# When adding an IP please also add a comment explaining what it covers
#
# - 195.225.216.150: Carrenza staging
variable "environment_cidrs" {
  description = "CSV of allowed CIDR addresses for this environment"
  default = "195.225.216.150/32"
}
