# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Provisioning:
#      - EC2 instance with cloud-init user data
#      - Security group for EC2 instance
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

# resource "random_string" "rds_password" {
#   length           = 12
#   special          = true
#   override_special = "!#$&"
#   keepers = {
#     kepper1 = var.name
#   }
# }

# resource "aws_ssm_parameter" "rds_password" {
#   name        = "/prod/mysql"
#   description = "Master password for mysql"
#   type        = "SecureString"
#   value       = random_string.rds_password.result
# }


resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_latest.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_access.id]
  #user_data_base64       = data.template_cloudinit_config.nginx.rendered
  user_data = file("./templates/userdata.tftpl")

  tags = {
    Name    = "${var.env}"
    Project = "${var.project}"
  }
}

resource "aws_security_group" "web_access" {
  name        = "web access group"
  description = "Security group for ${var.env} with pre-installed ${var.project}"
  vpc_id      = data.aws_vpcs.my_vpcs.ids[0]

  dynamic "ingress" {
    for_each = var.srv_sg_inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.alb_sg_inbound_ports
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

resource "aws_security_group" "alb_access" {
  name        = "alb access group"
  description = "Security group for ALB"
  vpc_id      = data.aws_vpcs.my_vpcs.ids[0]

  dynamic "ingress" {
    for_each = var.alb_sg_inbound_ports
    content {
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
    Name    = "${var.env}"
    Project = "${var.project}"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "TG-main"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpcs.my_vpcs.ids[0]
  health_check {
    healthy_threshold   = 3
    interval            = 10
    unhealthy_threshold = 3
    timeout             = 5
    path                = "/app2"
    port                = 80
  }
}


resource "aws_lb" "app_lb" {
  name                             = "ALB"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb_access.id]
  subnets                          = ["subnet-038905b5d3f7c0d09", "subnet-074f1e6c26f0f416b", "subnet-057d7db30bc58a0ef"]
  enable_cross_zone_load_balancing = "true"
  tags = {
    Name    = "${var.env}"
    Project = "${var.project}"
  }
}

resource "aws_lb_target_group_attachment" "att" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.app_lb.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}
