# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Provisioning:
#      - EC2 instance with cloud-init user data
#      - Security group for EC2 instance
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "nginx" {
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.nginx_access.id]
  user_data_base64       = data.template_cloudinit_config.nginx.rendered

  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    # Path to your ssh key
    private_key = file("./ssh/id_rsa")
    timeout     = "1m"
  }

  provisioner "file" {
    source      = "./templates/favicon.ico"
    destination = "/tmp/favicon.ico"
  }

  provisioner "remote-exec" {
    inline = [
      # Waiting until file will be downloaded to the remote instance
      "sleep 30 && sudo mv /tmp/favicon.ico /var/www/html",
    ]
  }

  tags = {
    Name    = "${var.env}"
    Project = "${var.project}"
  }
}

resource "aws_security_group" "nginx_access" {
  name        = "Nginx access group 2"
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

