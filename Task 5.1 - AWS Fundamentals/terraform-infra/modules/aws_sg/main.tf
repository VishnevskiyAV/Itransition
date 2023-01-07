# ___________________________________________________
# Terraform
#
# Provisioning:
#   - Security Group for ALB
#   - Security Group for Server
#
# Made by Aleksandr Vishnevskiy
# ___________________________________________________

# Security Group for ALB
resource "aws_security_group" "alb_security_group" {
  name   = "${var.env}-ALB-SG"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.alb_inbound_ports
    content {
      description = "Allows external connections to ALB on ports 80, 443"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-ALB-SG"
  }
}

# Security Group for Server

resource "aws_security_group" "server_security_group" {
  name        = "web-sg-${var.env}-security group"
  description = "Security group web-sg in ${var.env}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.srv_inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_cidr_blocks]
    }
  }

    dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["10.1.0.0/16"]
    }
  }

  dynamic "ingress" {
    for_each = var.alb_inbound_ports
    content {
      description     = "Access from ALB to EC2"
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.alb_security_group.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-security-group"
  }
}

