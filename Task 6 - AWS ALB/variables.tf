# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Variables for created resources  
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------------
# EC2 Parameters 
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "SSH key name"
  default     = "Frankfurt-vish"
}

variable "env" {
  default = "Nginx"
}

variable "project" {
  default = "Wordpress"
}

variable "domain" {
  description = "Name of SSL Certificate attached to domain name"
  type        = string
  default     = "avweb.link"
}
# ----------------------------------------------------------------------------------------------------------------------
# Security group Parameters 
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------

variable "sg_inbound_ports" {
  type        = list(any)
  description = "Inbound rules for security group"
  default     = ["22"]
}

variable "alb_inbound_ports" {
  description = "Load Balancer inbound ports for security group"
  type        = list(any)
  default     = ["80", "443"]
}

# ----------------------------------------------------------------------------------------------------------------------
# Mysql Parameters for wordpress DB
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
variable "db_root_password" {
  type        = string
  description = "DB root password"
  default     = "root"
}

variable "db_username" {
  type        = string
  description = "DB wordpress username"
  default     = "wordpress"
}

variable "db_user_password" {
  type        = string
  description = "DB wordpress password"
  default     = "wordpress"
}

variable "db_name" {
  type        = string
  description = "DB wordpress name"
  default     = "wordpress"
}

# ----------------------------------------------------------------------------------------------------------------------
# Nginx parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------


variable "listen_port" {
  type        = string
  description = "Listen port for server"
  default     = 80
}
