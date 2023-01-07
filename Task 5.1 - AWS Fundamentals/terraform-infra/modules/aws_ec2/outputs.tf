output "instance_ids" {
  description = "List of instance IDs"
  value       = aws_instance.nginx[*].id
}

output "instance_ips" {
   description = "List of instance IPs"
   value = aws_instance.nginx[*].public_ip
}

output "lb_dns_name" {
  description = "LB DNS Name"
  value = aws_elb.load_balancer.dns_name
}