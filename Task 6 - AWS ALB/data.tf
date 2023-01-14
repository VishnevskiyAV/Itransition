# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# DATA:
#   - Latest AMI
#   - SSL Sertificate
#   - VPC id
#   - Subnets id
#   - Route53 HZ
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

data "aws_ami" "ubuntu_latest" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_acm_certificate" "cert_arn" {
  domain   = var.domain
  statuses = ["ISSUED"]
}

data "aws_vpcs" "my_vpcs" {}


data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.my_vpcs.ids[0]]
  }
}

data "aws_subnet" "default" {
  for_each = toset(data.aws_subnets.default.ids)
  id       = each.value
}

data "aws_route53_zone" "domain" {
  name         = var.domain
  private_zone = false
}

