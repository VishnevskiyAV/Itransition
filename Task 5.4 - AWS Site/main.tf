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
  user_data = templatefile("./templates/userdata.tftpl", {
    #new_password = data.aws_ssm_parameter.my_rds_password.value,
    app_path     = "/var/www"
  })

  tags = {
    Name    = "${var.env}"
    Project = "${var.project}"
  }
}

resource "aws_security_group" "web_access" {
  name        = "webaccess group"
  description = "Security group for ${var.env} with pre-installed ${var.project}"
  vpc_id      = data.aws_vpcs.my_vpcs.ids[0]

  dynamic "ingress" {
    for_each = var.sg_inbound_ports
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

