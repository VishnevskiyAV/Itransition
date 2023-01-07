# ----------------------------------------------------------------------------------------------------------------------
# VPC & subnets parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------

variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC"
  type    = string
  default = "10.1.0.0/16"
}

variable "env" {
  description = "Environment name, will be added to all tags and some resource name"
  type    = string
  default = "task-5.1"
}

variable "public_subnet_cidrs" {
  description = "A list of public subnets inside the VPC"
  type = list(any)
  default = [
    "10.1.10.0/24",
    "10.1.20.0/24",
    "10.1.30.0/24",
  ]
}

# variable "private_subnet_cidrs" {
#   description = "A list of private subnets inside the VPC"
#   type = list(any)
#   default = [
#     "10.1.110.0/24",
#     "10.1.120.0/24",
#   ]
# }

# variable "single_nat_gateway" {
#   description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks or false if you want to provision NAT Gateways for each of your private networks"
#   type = bool
#   default = true
# }

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type    = bool
  default = true
}

