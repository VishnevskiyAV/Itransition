# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Find the latest ubuntu ami and vpc id
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------
data "aws_ami" "amazon_latest" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "ubuntu_latest" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# data "aws_ssm_parameter" "my_rds_password" {
#   name       = "/prod/mysql"
#   depends_on = [aws_ssm_parameter.rds_password]
# }

data "aws_vpcs" "my_vpcs" {} 

