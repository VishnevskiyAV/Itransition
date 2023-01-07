# ___________________________________________________
# Terraform
#
# Provisioning:
#   - RDS
#   - RDS Subnet Group
#
# Made by Aleksandr Vishnevskiy
# ___________________________________________________


# RDS Subnet Group
resource "aws_db_subnet_group" "default" {
  name       = lower(var.env)
  subnet_ids = [var.subnets[1], var.subnets[2]]

  tags = {
    Name = "${var.env}-DB-subnet-group"
  }
}

resource "aws_db_instance" "rds" {
  identifier                  = "postgres"
  db_name                     = "mypostgres"
  instance_class              = "db.t2.micro"
  storage_type                = var.storage_type
  allocated_storage           = 20
  engine                      = "postgres"
  engine_version              = "12" # To use db.t2.micro
  skip_final_snapshot         = true
  publicly_accessible         = false
  vpc_security_group_ids      = var.server_security_group
  username                    = "postgres"
  password                    = "postgres"
  db_subnet_group_name        = aws_db_subnet_group.default.id
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  apply_immediately           = true
}
