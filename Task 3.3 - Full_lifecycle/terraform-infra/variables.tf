# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Variables
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t3.xlarge"
}

variable "key_name" {
  type        = string
  description = "SSH key name"
  default     = "Frankfurt-vish"
}

variable "env" {
  type        = string
  description = "Environment name"
  default     = "infra"
}

variable "project" {
  default = "full_lifeycle"
}

# ----------------------------------------------------------------------------------------------------------------------
# Security group Parameters 
# ----------------------------------------------------------------------------------------------------------------------

variable "sg_inbound_ports" {
  type        = list(any)
  description = "Inbound rules for security group"
  default     = ["80", "443", "22", "5022", "9000", "8081"]
}

# ----------------------------------------------------------------------------------------------------------------------
# Install parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------

variable "GITLAB_HOME" {
  default = "/srv/gitlab"
}
