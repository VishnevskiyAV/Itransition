# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Cloud-init data
#     - For nginx
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

# Render a multi-part cloud-init config making use of the part above, and other source files (https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config)

data "template_cloudinit_config" "nginx" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    content_type = "text/cloud-config"
    content = templatefile("../modules/aws_ec2/cloud-init.yaml", {
      distro = "ubuntu",
    })
  }
}
