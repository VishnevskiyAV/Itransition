# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Provisioning:
#      - EC2 infra instance with cloud-init user data
#      - Infra Security group
#      - EC2 app instance
#      - App Security group
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "infra" {
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.infra.id]
  user_data_base64       = data.template_cloudinit_config.infra.rendered

  root_block_device {
    volume_size = 30
  }


  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    # Path to your ssh key
    private_key = file("./ssh/id_rsa")
    timeout     = "1m"
  }

  provisioner "file" {
    source      = "../docker/"
    destination = "/tmp"
  }

  tags = {
    Name    = "${var.env}"
    Project = "${var.project}"
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "aws_security_group" "infra" {
  name        = "git access group"
  description = "Security group for ${var.env}"
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

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.app.id]
  user_data              = <<EOF
#!/bin/bash
apt-get -y update && apt-get install -y --no-install-recommends apt-utils
apt -y install default-jdk -y
sh -c 'echo PubkeyAcceptedKeyTypes +ssh-rsa >>/etc/ssh/sshd_config' 
systemctl restart sshd
EOF

  tags = {
    Name    = "app"
    Project = "${var.project}"
  }
}

resource "aws_security_group" "app" {
  name        = "app access group"
  description = "Security group for app"
  vpc_id      = data.aws_vpcs.my_vpcs.ids[0]

  dynamic "ingress" {
    for_each = ["22", "80"]
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
    Name    = "app"
    Project = "${var.project}"
  }
}
