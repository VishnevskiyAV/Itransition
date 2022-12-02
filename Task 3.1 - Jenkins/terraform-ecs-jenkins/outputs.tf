# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Outputs of created resources
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

data "aws_instances" "get_asg_instance" {
  filter {
    name   = "tag:Name"
    values = ["${var.env}-ECS-cluster"]
  }
}

output "public_ip" {
  value = join(",", data.aws_instances.get_asg_instance.public_ips)
}