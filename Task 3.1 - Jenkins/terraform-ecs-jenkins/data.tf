# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Find the latest ubuntu ecs ami and vpc id
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

data "aws_ami" "latest_amazon_ecs" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }
}

data "aws_vpcs" "my_vpcs" {} 

data "aws_availability_zones" "all_azs" {} 

data "aws_subnets" "my_subnets" {}

data "aws_efs_file_system" "efs" {
  file_system_id = var.EFSJenkinsVolume
}