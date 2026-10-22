variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_type" {
  description = "EC2 instance type for Dev."
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "Your trusted public IP in CIDR form, e.g. 203.0.113.10/32."
  type        = string
  default     = "127.0.0.1/32"
}
