# ___________________________________________________
# Terraform
#
# Provisioning:
#   - EC2 instance with Nginx
#   - CLB
#
# Made by Aleksandr Vishnevskiy
# ___________________________________________________

resource "aws_instance" "nginx" {
  count                  = var.server_count
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.server_security_group
  user_data_base64       = data.template_cloudinit_config.nginx.rendered
  subnet_id              = element(var.subnets[*], count.index)
  iam_instance_profile   = aws_iam_instance_profile.ec2_service_instance_profile.name

  tags = {
    Name = "${var.env}-${count.index + 1}"
  }
}


# CLB

resource "aws_elb" "load_balancer" {
  name                        = "Classic-LB"
  subnets                     = var.subnets
  security_groups             = var.alb_security_group
  internal                    = false
  cross_zone_load_balancing   = true
  instances                   = aws_instance.nginx[*].id
  connection_draining         = true
  connection_draining_timeout = 30

  idle_timeout = 60

  dynamic "listener" {
    for_each = var.listeners
    content {
      instance_port      = listener.value.instance_port
      instance_protocol  = listener.value.instance_protocol
      lb_port            = listener.value.lb_port
      lb_protocol        = listener.value.lb_protocol
      ssl_certificate_id = listener.value.ssl_certificate_id
    }
  }

  health_check {
    target              = "TCP:80"
    timeout             = 5
    interval            = 10
    unhealthy_threshold = 3
    healthy_threshold   = 3
  }

  tags = {
    Name = "elb-${var.env}"
  }

  depends_on = [
    aws_instance.nginx
  ]
}



