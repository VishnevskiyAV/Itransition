# ----------------------------------------------------------------------------------------------------------------------
# Security Group REQUIRED PARAMETERS
# These variables must be set when using this module.
# ----------------------------------------------------------------------------------------------------------------------
variable "vpc_id" {
  description = "ID of existing VPC"
  type        = string
}

variable "subnets" {
  type        = list(any)
  description = "Subnets ID"
  default     = []
}

variable "server_security_group" {
  type        = list(any)
  description = "Server security group"
  default     = []
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

variable "storage_type" {
  type        = string
  description = "One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD)"
  default     = "gp2"
}

