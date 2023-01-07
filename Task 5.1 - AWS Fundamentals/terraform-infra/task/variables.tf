# ----------------------------------------------------------------------------------------------------------------------
# Common Parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
variable "env" {
  description = "Environment name, will be added to tags and some resource name"
  type        = string
  default     = "task-5.1"
}

# ----------------------------------------------------------------------------------------------------------------------
# VPC Parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "A list of public subnets inside the VPC"
  default = [
    "10.1.10.0/24",
    "10.1.20.0/24",
    "10.1.30.0/24",
  ]
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

# ----------------------------------------------------------------------------------------------------------------------
# Security groups Parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
variable "srv_inbound_ports" {
  description = "Server inbound ports for security group"
  type        = list(any)
  default     = ["22", "5432"]
}

variable "sg_cidr_blocks" {
  description = "CIDR blocks for security group"
  type        = string
  default     = "37.232.34.149/32"
}

variable "alb_inbound_ports" {
  description = "Load Balancer inbound ports for security group"
  type        = list(any)
  default     = ["80", "443"]
}

# ----------------------------------------------------------------------------------------------------------------------
# EC2 instance Parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
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

variable "listen_port_proxy" {
  type        = string
  description = "Listen port for reverse proxy"
  default     = 80
}

variable "server_count" {
  type        = string
  description = "Count of servers (each server will be created in new subnet)"
  default     = "2"
}

# ----------------------------------------------------------------------------------------------------------------------
# ECS Parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
# variable "EFSConfigVolume" {
#   description = "Name of EFS Configuration volume"
#   type        = string
#   default     = "fs-1b0ac243"
# }

# variable "EFSBackupVolume" {
#   description = "Name of EFS Backup volume"
#   type        = string
#   default     = "fs-5695720f"
# }

# variable "InstanceType" {
#   description = "EC2 Instance Type"
#   type        = string
#   default     = "t3a.medium"
# }

# variable "keyname" {
#   description = "EC2 key paire name for SSH connection to EC2"
#   type        = string
#   default     = "Frankfurt-enterpay"
# }

# variable "ClusterSize" {
#   description = "The ECS Cluster Size"
#   type        = string
#   default     = 1
# }

# variable "MaxClusterSize" {
#   description = "The ECS Maximum Cluster Size"
#   type        = string
#   default     = 2
# }

# variable "base_cp" {
#   description = "The base value of default capacity provider strategy"
#   type        = string
#   default     = 0
# }

# variable "weight_cp" {
#   description = "The weight value of default capacity provider strategy"
#   type        = string
#   default     = 100
# }

# variable "maximum_scaling_step_size" {
#   description = "The maximum scaling step size for autoscalling capacity provider "
#   type        = string
#   default     = 1
# }

# variable "minimum_scaling_step_size" {
#   description = "The minimum scaling step size for autoscalling capacity provider "
#   type        = string
#   default     = 1
# }

# variable "target_capacity" {
#   description = "The target capacity for autoscalling capacity provider "
#   type        = string
#   default     = 100
# }

# ----------------------------------------------------------------------------------------------------------------------
# RDS Parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
# variable "identifier" {
#   type        = string
#   description = "The name of db"
#   default     = "test-db"
# }

# variable "security_group_ids" {
#   default = []
# }

# variable "deletion_protection" {
#   type        = string
#   description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false"
#   default     = true
# }

# variable "delete_automated_backups" {
#   type        = string
#   description = "When DB is deleted, all automatic backups will also be deleted, only final snapshot will remain"
#   default     = true
# }

# variable "instance_class" {
#   type        = string
#   description = "The instance type of the RDS instance"
#   default     = "db.t3.medium"
# }

# variable "engine" {
#   type        = string
#   description = "The db engine"
#   default     = "mysql"
# }

# variable "engine_version" {
#   type        = string
#   description = "The db engine version"
#   default     = "5.7.38"
# }

# variable "username" {
#   type        = string
#   description = "Username for the master DB user"
#   default     = "enterpay"
# }

# variable "db_port" {
#   type        = string
#   description = "The port on which the DB accepts connections"
#   default     = "3306"
# }

# variable "allocated_storage" {
#   type        = string
#   description = "The allocated storage in gigabytes. For read replica, set the same value as master's"
#   default     = "20"
# }

# variable "option_group_name" {
#   type        = string
#   description = "Name of the DB parameter group to associate"
#   default     = "default:mysql-5-7"
# }

# variable "parameter_group_name" {
#   type        = string
#   description = "Name of the DB parameter group to associate"
#   default     = "default.mysql5.7"
# }

# variable "enabled_cloudwatch_logs_exports" {
#   type        = list(string)
#   default     = []
#   description = "List of log types to enable for exporting to CloudWatch logs"
# }

# variable "create_password" {
#   type        = bool
#   description = "Create password for DB. Generates automatically if value True. Recreate if the change_password parameter is changed"
#   default     = false
# }

# variable "change_password" {
#   type        = string
#   description = "The keeper for changing db password"
#   default     = ""
# }

# variable "apply_immediately" {
#   type        = string
#   description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
#   default     = false
# }

# variable "ca_cert_identifier" {
#   type        = string
#   description = "Specifies the identifier of the CA certificate for the DB instance"
#   default     = "rds-ca-2019"
# }

# variable "additional_tags" {
#   type        = map(string)
#   default     = {}
#   description = "The additional aws_db_instance tags that will be merged over the default tags"
# }

# variable "monitoring_role_arn" {
#   type        = string
#   description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
#   default     = ""
# }

# variable "performance_insights_enabled" {
#   type        = string
#   description = "The values which defines if the performance insights for this db will be enabled or not"
#   default     = "false"
# }

# variable "monitoring_interval" {
#   type        = string
#   description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
#   default     = null
# }

# variable "snapshot_identifier" {
#   type        = string
#   description = "The snapshot ID used to restore the DB instance"
#   default     = ""
# }

# variable "copy_tags_to_snapshot" {
#   type        = string
#   description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
#   default     = "true"
# }

# variable "skip_final_snapshot" {
#   type        = string
#   description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
#   default     = "false"
# }

# variable "backup_retention_period" {
#   type        = string
#   description = "The days to retain backups for"
#   default     = 1
# }

# variable "backup_window" {
#   type        = string
#   description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Before and not overlap with maintenance_window"
#   default     = "02:00-02:30"
# }

# variable "maintenance_window" {
#   type        = string
#   description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'"
#   default     = "mon:02:30-mon:03:00"
# }
# ----------------------------------------------------------------------------------------------------------------------
# RDS Read-replica Parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
# variable "identifier_rr" {
#   type        = string
#   description = "The name of db read-replica"
#   default     = "test-db-replica"
# }

# variable "deletion_protection_rr" {
#   type        = string
#   description = "If the DB read-replica instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false"
#   default     = false
# }

# variable "delete_automated_backups_rr" {
#   type        = string
#   description = "When the DB read-replica is deleted, all automatic backups will also be deleted, only final snapshot will remain"
#   default     = true
# }

# variable "db_port_rr" {
#   type        = string
#   description = "The port on which the DB read-replica accepts connections"
#   default     = "3306"
# }

# variable "instance_class_rr" {
#   type        = string
#   description = "The instance type of the RDS instance for read-replica"
#   default     = "db.t3.small"
# }

# variable "option_group_name_rr" {
#   type        = string
#   description = "Name of the DB parameter group to associate"
#   default     = "default:mysql-5-7"
# }

# variable "parameter_group_name_rr" {
#   type        = string
#   description = "Name of the DB parameter group to associate"
#   default     = "default.mysql5.7"
# }

# variable "enabled_cloudwatch_logs_exports_rr" {
#   type        = list(string)
#   default     = []
#   description = "List of log types to enable for exporting to CloudWatch logs"
# }

# # ----------------------------------------------------------------------------------------------------------------------
# # Tasks Parameters
# # These variables have defaults, but may be overridden.
# # ----------------------------------------------------------------------------------------------------------------------
# variable "enabled_task_main" {
#   default = true
# }

# variable "enabled_task_ui" {
#   default = true
# }

# variable "enabled_task_actors" {
#   default = true
# }

# variable "service_name_main" {
#   default = "main"
# }

# variable "service_name_ui" {
#   default = "ui"
# }

# variable "service_name_actors" {
#   default = "actors"
# }

# variable "requires_compatibilities" {
#   default = "EC2"
# }

# variable "task_container_image_main" {
#   default = "043048561210.dkr.ecr.eu-central-1.amazonaws.com/enterpay-main:135"
# }

# variable "task_container_image_ui" {
#   default = "043048561210.dkr.ecr.eu-central-1.amazonaws.com/enterpay-ui-test:2.test"
# }

# variable "task_container_image_actors" {
#   default = "043048561210.dkr.ecr.eu-central-1.amazonaws.com/enterpay-actors:23"
# }

# variable "task_definition_cpu_main" {
#   default = "1024"
# }

# variable "task_definition_memory_main" {
#   default = "2048"
# }

# variable "task_definition_cpu_ui" {
#   default = "512"
# }

# variable "task_definition_memory_ui" {
#   default = "512"
# }

# variable "task_definition_cpu_actors" {
#   default = "512"
# }

# variable "task_definition_memory_actors" {
#   default = "512"
# }

# variable "container_port_main" {
#   default = "8080"
# }

# variable "container_port_ui" {
#   default = "8081"
# }

# variable "container_port_actors" {
#   default = "8082"
# }

# variable "task_container_memory_reservation" {
#   default = null
# }


# ----------------------------------------------------------------------------------------------------------------------
# Target Group Parameters
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
# variable "tg_module_enabled_main" {
#   default = true
# }

# variable "tg_module_enabled_ui" {
#   default = true
# }

# variable "target_type" {
#   default = "instance"
# }

# variable "protocol" {
#   default = "HTTP"
# }

# # Listener Parameters and SSL Certificate

# variable "domain" {
#   default = "test.laskuyritykselle.fi"
# }

