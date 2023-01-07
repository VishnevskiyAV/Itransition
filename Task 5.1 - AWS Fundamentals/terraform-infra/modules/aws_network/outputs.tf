output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value = aws_subnet.public_subnets[*].id
}

# output "private_subnet_ids" {
#   description = "List of IDs of private subnets"
#   value = aws_subnet.private_subnets[*].id
# }
