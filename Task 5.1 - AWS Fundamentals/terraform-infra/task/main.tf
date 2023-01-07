#Locals
locals {
  vpc_id = module.vpc.vpc_id
  alb_sg = module.sg.alb_security_group
  srv_sg = module.sg.server_security_group
}


# Modules
module "vpc" {
  source              = "../modules/aws_network"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "sg" {
  source            = "../modules/aws_sg"
  env               = var.env
  vpc_id            = local.vpc_id
  sg_cidr_blocks    = var.sg_cidr_blocks
  alb_inbound_ports = var.alb_inbound_ports
  srv_inbound_ports = var.srv_inbound_ports

  depends_on = [
    module.vpc
  ]
}

module "ec2" {
  source                = "../modules/aws_ec2"
  env                   = var.env
  server_security_group = [local.srv_sg]
  subnets               = module.vpc.public_subnet_ids
  server_count          = var.server_count
  key_name              = var.key_name
  instance_type         = var.instance_type
  alb_security_group    = [local.alb_sg]
  vpc_id                = local.vpc_id

  listeners = [
    {
      lb_port            = 80
      lb_protocol        = "HTTP"
      instance_port      = 80
      instance_protocol  = "HTTP"
      ssl_certificate_id = ""
    }
  ]

  depends_on = [
    module.sg
  ]
}

module "rds" {
  source                = "../modules/aws_rds"
  vpc_id                = local.vpc_id
  env                   = var.env
  server_security_group = [local.srv_sg]
  subnets               = module.vpc.public_subnet_ids
}


module "elasticache" {
  source                = "../modules/aws_elacticache"
  subnets               = module.vpc.public_subnet_ids
  vpc_id                = local.vpc_id
  server_security_group = [local.srv_sg]
}

