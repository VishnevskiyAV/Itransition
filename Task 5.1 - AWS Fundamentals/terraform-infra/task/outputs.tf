output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}



output "instance_ips" {
  description = "List of instance IPs"
  value       = module.ec2.instance_ips
}

output "lb_dns_name" {
  description = "LB DNS Name"
  value       = module.ec2.lb_dns_name
}

output "rds_endpoint" {
  description = "RDS Endpoint address"
  value       = module.rds.rds_endpoint
}

output "redis_endpoint" {
  description = "Redis endpoint "
  value       = module.elasticache.redis_endpoint
}

output "memcached_endpoint" {
  description = "Memcached endpoint"
  value       = module.elasticache.memcached_endpoint
}
