output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.this.id
}

output "subnet_id" {
  description = "Public subnet ID."
  value       = aws_subnet.public.id
}

output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "Public IPv4 address of the EC2 instance."
  value       = aws_instance.this.public_ip
}

output "security_group_id" {
  description = "EC2 security group ID."
  value       = aws_security_group.ec2.id
}
