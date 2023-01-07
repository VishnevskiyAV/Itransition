output "alb_security_group" {
  description = "The Security Group for Aplication Load Balancer"
  value = aws_security_group.alb_security_group.id
}

output "server_security_group" {
  description = "The Security Group for EC2 instance"
  value = aws_security_group.server_security_group.id
}

