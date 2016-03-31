# Integration environment allowed IP addresses
# When adding an IP please also add a comment explaining what it covers
#
# - 31.210.245.86: Carrenza production
variable "environment_cidrs" {
  description = "CSV of allowed CIDR addresses for this environment"
  default = "31.210.245.86/32"
}
