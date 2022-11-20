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

data "template_cloudinit_config" "nginx" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    content_type = "text/cloud-config"
    content = templatefile("./templates/cloud-init.yaml", {
      db_root_password = var.db_root_password,
      db_username      = var.db_username,
      db_user_password = var.db_user_password,
      db_name          = var.db_name
      proxy_content = base64gzip(templatefile("./templates/nginx80.conf", {
        listen_port_proxy = var.listen_port_proxy
        listen_port_back  = var.listen_port_back
      }))
      nginx_content = base64gzip(templatefile("./templates/nginx.conf", {
        #  you can use vars for nginx config file 
      }))
      php_content = base64gzip(templatefile("./templates/wp-config.sh", {
        db_username      = var.db_username,
        db_user_password = var.db_user_password,
        db_name          = var.db_name
      }))
    })
  }
}
