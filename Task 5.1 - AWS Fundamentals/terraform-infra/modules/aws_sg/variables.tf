# ----------------------------------------------------------------------------------------------------------------------
# Security Group REQUIRED PARAMETERS
# These variables must be set when using this module.
# ----------------------------------------------------------------------------------------------------------------------
variable "vpc_id" {
  description = "ID of existing VPC"
  type        = string
}

# ----------------------------------------------------------------------------------------------------------------------
# Security Group parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------

variable "env" {
  description = "Environment name, will be added to tags and some resource name"
  type        = string
  default     = "task-5.1"
}

variable "alb_inbound_ports" {
  description = "Load Balancer inbound ports for security group"
  type        = list(any)
  default     = ["80", "443"]
}

variable "srv_inbound_ports" {
  description = "Server inbound ports for security group"
  type        = list(any)
  default     = ["80", "443", "22"]
}

variable "ports" {
  description = "Server inbound ports for diff services"
  type        = list(any)
  default     = ["5432", "11211", "6379"]
}

variable "sg_cidr_blocks" {
  description = "CIDR blocks for security group"
  type        = string
  default     = "37.232.34.149/32"
}
