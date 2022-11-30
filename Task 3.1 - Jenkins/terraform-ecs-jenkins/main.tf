# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Provisioning:
#      - ECS cluster
#      - Autoscalling group
#      - Launch configuration
#      - Security group
#      - MountTarget for EFS
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------


locals {
  userdata = templatefile("./user_data.tftpl", {
    ecs_cluster           = aws_ecs_cluster.main.name
    EFSJenkinsVolume      = var.EFSJenkinsVolume
  })
}

# ECS cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.env}-ECS-Cluster"

  tags = {
    Name = "${var.env}-ECS-Cluster"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Autoscalling group
resource "aws_autoscaling_group" "main" {
  name                      = "${aws_launch_configuration.main.name}-asg"
  launch_configuration      = aws_launch_configuration.main.name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = "EC2"
  health_check_grace_period = 60
  vpc_zone_identifier       = [join(",", data.aws_subnets.my_subnets.ids)]

  tag {
    key                 = "Name"
    value               = "${var.env}-ECS-cluster"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Launch configuration
resource "aws_launch_configuration" "main" {
  name_prefix     = "${var.env}-ECS-cluster-LC"
  security_groups = [aws_security_group.main.id]

  key_name                    = var.keyname
  image_id                    = data.aws_ami.latest_amazon_ecs.id
  instance_type               = var.InstanceType
  iam_instance_profile        = aws_iam_instance_profile.ecs_instance_profile.id
  user_data                   = local.userdata
  associate_public_ip_address = true

  lifecycle {
    ignore_changes        = [image_id]
    create_before_destroy = true
  }
}

#Provisioning Security group
resource "aws_security_group" "main" {
  name        = "${var.env}-ECS-security-group"
  description = "Security group for ${var.env} ECS cluster"
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
    Name = "${var.env}-Security-Group"
  }
}

# MountTarget for EFS
resource "aws_efs_mount_target" "EFSConfigVolume" {
  count           = length(data.aws_subnets.my_subnets.ids)
  file_system_id  = var.EFSJenkinsVolume
  subnet_id       = element(data.aws_subnets.my_subnets.ids, count.index)
  security_groups = [aws_security_group.main.id]
}

