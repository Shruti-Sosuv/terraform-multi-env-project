output "vpc_id" {
  value       = module.environment.vpc_id
  description = "Prod VPC ID."
}

output "subnet_id" {
  value       = module.environment.subnet_id
  description = "Prod public subnet ID."
}

output "instance_id" {
  value       = module.environment.instance_id
  description = "Prod EC2 instance ID."
}

output "instance_public_ip" {
  value       = module.environment.instance_public_ip
  description = "Prod EC2 public IP."
}
