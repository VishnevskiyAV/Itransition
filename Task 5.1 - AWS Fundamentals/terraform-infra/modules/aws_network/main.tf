# ___________________________________________________
# Terraform
#
# Provisioning:
#   - VPC
#   - Internet gateway
#   - XX Public Subnets
#   - XX Private Subnets
#   - Nat Gateway
#
# Made by Aleksandr Vishnevskiy
# ___________________________________________________

# There is no provider for module
# locals {
#   nat_gateway_count = var.single_nat_gateway ? 1 : length(var.private_subnet_cidrs)
# }

# Data
data "aws_availability_zones" "available" {}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.env}-vpc"
  }
}

# Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}

# Public Subnets and routing
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.env}-route-public-subnets"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}

resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [aws_subnet.public_subnets[2].id]

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.1.0.0/16"
    from_port  = 0
    to_port    = 0
  }

    ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.env}-acl"
  }
}

# # NAT gateway with EIP
# resource "aws_eip" "nat" {
#   count = local.nat_gateway_count
#   vpc   = true

#   tags = {
#     Name = "${var.env}-nat-gw-${count.index + 1}"
#   }
# }

# resource "aws_nat_gateway" "nat" {
#   count         = local.nat_gateway_count
#   allocation_id = aws_eip.nat[count.index].id
#   subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)

#   tags = {
#     Name = "${var.env}-nat-gw-${count.index + 1}"
#   }
# }

# # Private Subnets and routing
# resource "aws_subnet" "private_subnets" {
#   count                   = length(var.private_subnet_cidrs)
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = element(var.private_subnet_cidrs, count.index)
#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "${var.env}-private-${count.index + 1}"
#   }
# }

# resource "aws_route_table" "private_subnets" {
#   count  = local.nat_gateway_count
#   vpc_id = aws_vpc.main.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat[count.index].id
#   }

#   tags = {
#     Name = "${var.env}-route-private-subnets-${count.index + 1}"
#   }
# }

# resource "aws_route_table_association" "private_routs" {
#   count          = length(aws_subnet.private_subnets[*].id)
#   route_table_id = element(aws_route_table.private_subnets[*].id, count.index)
#   subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
# }


