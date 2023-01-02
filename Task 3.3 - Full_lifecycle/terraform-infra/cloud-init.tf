# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Cloud-init data
#     - For nginx
#     - For mysql
#     - For wordpress
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

# Render a multi-part cloud-init config making use of the part above, and other source files (https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config)

data "template_cloudinit_config" "infra" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    content_type = "text/cloud-config"
    content = templatefile("./templates/cloud-init.yaml", {
      GITLAB_HOME = var.GITLAB_HOME,
    })
  }
}
