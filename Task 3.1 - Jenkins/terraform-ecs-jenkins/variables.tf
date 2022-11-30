# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Variables for created resources  
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

variable "env" {
  type        = string
  description = "Environment name"
  default     = "Jenkins"
}

# ----------------------------------------------------------------------------------------------------------------------
# Security group Parameters 
# ----------------------------------------------------------------------------------------------------------------------

variable "sg_inbound_ports" {
  type        = list(any)
  description = "Inbound rules for security group"
  default     = ["80", "8080", "22", "50000", "2049"]
}

# ----------------------------------------------------------------------------------------------------------------------
# Autoscalling group Parameters 
# ----------------------------------------------------------------------------------------------------------------------

variable "min_size" {
  type        = string
  description = "min size of instancies in autoscalling group"
  default     = "1"
}

variable "max_size" {
  type        = string
  description = "max size of instancies in autoscalling group"
  default     = "4"
}

variable "desired_capacity" {
  type        = string
  description = "desired capacity of instancies in autoscalling group"
  default     = "1"
}

# ----------------------------------------------------------------------------------------------------------------------
# Launch Configuratin Parameters 
# ----------------------------------------------------------------------------------------------------------------------

variable "keyname" {
  description = "EC2 key paire name for SSH connection to EC2"
  type        = string
  default     = "Frankfurt-vish"
}

variable "InstanceType" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.medium"
}

variable "EFSJenkinsVolume" {
  type = string
  description = "Jenkins confug volume"
  default = "fs-075b537041f7d3b25"
}
