# Override this variable for each environment
variable "environment_cidrs" {
  description = "CSV of allowed CIDR addresses for this environment"
  default = "127.0.0.1/32"
}
