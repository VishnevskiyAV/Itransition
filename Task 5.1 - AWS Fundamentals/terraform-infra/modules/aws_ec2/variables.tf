# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ----------------------------------------------------------------------------------------------------------------------

variable "server_security_group" {
  type        = list(any)
  description = "Server security group"
  default     = []
}

variable "alb_security_group" {
  type        = list(any)
  description = "NLB security group"
  default     = []
}

variable "subnets" {
  type        = list(any)
  description = "Subnets ID where the instances will be created"
  default     = []
}

variable "vpc_id" {
  description = "ID of existing VPC"
  type        = string
}

variable "listeners" {
  description = "A list of listener configurations for the ELB."
  type        = list(object({
    lb_port : number
    lb_protocol : string
    instance_port : number
    instance_protocol : string
    ssl_certificate_id : string
  }))
}

# ----------------------------------------------------------------------------------------------------------------------
# parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------

variable "server_count" {
  type        = string
  description = "Count of servers (each server will be created in new subnet)"
  default     = "1"
}

variable "env" {
  description = "Environment name, will be added to tags and some resource name"
  type        = string
  default     = "task-5.1"
}

variable "key_name" {
  type        = string
  description = "SSH key name"
  default     = "Frankfurt-vish"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t2.micro"
}



