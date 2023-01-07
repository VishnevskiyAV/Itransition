# ___________________________________________________
# Terraform
#
# Provisioning:
#   - ElastiCache memcached subnet group
#   - ElastiCache memcached cluster
#   - ElastiCache redis subnet group
#   - ElastiCache redis cluster
#
# Made by Aleksandr Vishnevskiy
# ___________________________________________________

resource "aws_elasticache_subnet_group" "memcached" {
  name       = "memcached-subnet-group"
  subnet_ids = var.subnets
}


resource "aws_elasticache_cluster" "memcached" {
  cluster_id           = "cluster-memcached"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  subnet_group_name    = aws_elasticache_subnet_group.memcached.name
  security_group_ids   = var.server_security_group
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-subnet-group"
  subnet_ids = var.subnets
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "cluster-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = var.server_security_group
}
