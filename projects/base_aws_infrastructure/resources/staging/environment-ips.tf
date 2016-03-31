# Integration environment allowed IP addresses
# When adding an IP please also add a comment explaining what it covers
#
# - 31.210.245.70: Carrenza staging
variable "environment_cidrs" {
  description = "CSV of allowed CIDR addresses for this environment"
  default = "31.210.245.70/32"
}
