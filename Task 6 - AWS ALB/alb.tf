# ___________________________________________________
# Terraform
#
# Provisioning:
#   - Application LoadBalancer
#   - Default Listener Rule
#   - Listener Rule for HTTP
#   - Target Group
#   - Target Group Attachment
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

# Application LoadBalancer
resource "aws_alb" "alb" {
  name            = "${var.env}-ALB"
  subnets         = [for s in data.aws_subnet.default : s.id]
  security_groups = [aws_security_group.alb_access.id]
  enable_http2    = "true"
  idle_timeout    = 30
}

# Default Listener Rule
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.cert_arn.arn

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# Listener rule for HTTP

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Target Group
resource "aws_lb_target_group" "tg" {
  name                 = "${var.env}-target-group"
  target_type          = "instance"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = data.aws_vpcs.my_vpcs.ids[0]
  deregistration_delay = 5
  health_check {
    healthy_threshold   = 3
    interval            = 6
    unhealthy_threshold = 3
    timeout             = 5
    path                = "/"
    protocol            = "HTTP"
    port                = 80
    matcher             = "200,302"

  }
}

# Target Group Attachment
resource "aws_lb_target_group_attachment" "nginx" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.nginx.id
  port             = 80
}

