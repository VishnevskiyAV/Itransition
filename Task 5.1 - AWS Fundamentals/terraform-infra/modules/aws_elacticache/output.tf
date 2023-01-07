output "redis_endpoint" {
  description = "Redis endpoint "
  value = aws_elasticache_cluster.redis.cluster_address
}

output "memcached_endpoint" {
  description = "Memcached endpoint"
  value = aws_elasticache_cluster.memcached.cluster_address
}

