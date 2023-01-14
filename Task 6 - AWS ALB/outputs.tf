# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Outputs of created resources
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

output "public_ip" {
  value = aws_instance.nginx.public_ip
}

output "alb_dns" {
  value = aws_alb.alb.dns_name
}
output "web_address" {
  value = aws_route53_record.alias_route53_record.name
}
