# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Outputs of created resources
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "alb_dns" {
  value = aws_lb.app_lb.dns_name
}