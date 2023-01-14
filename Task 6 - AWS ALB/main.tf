# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Provisioning:
#      - EC2 instance with cloud-init user data
#      - Security group for EC2 instance
#      - Security group for ALB
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "nginx" {
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.nginx_access.id]
  user_data_base64       = data.template_cloudinit_config.nginx.rendered

  tags = {
    Name    = "${var.env}"
    Project = "${var.project}"
  }
}

# Security Group for server
resource "aws_security_group" "nginx_access" {
  name   = "${var.env}-SERVER-SG"
  vpc_id = data.aws_vpcs.my_vpcs.ids[0]

  dynamic "ingress" {
    for_each = var.sg_inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.alb_inbound_ports
    content {
      description     = "Access from ALB to EC2"
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.alb_access.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.env}"
    Project = "${var.project}"
  }
}

# Security Group for ALB
resource "aws_security_group" "alb_access" {
  name   = "${var.env}-ALB-SG"
  vpc_id = data.aws_vpcs.my_vpcs.ids[0]

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
