variable "name" {
  description = "Prefix used for resource names."
  type        = string
}

variable "environment" {
  description = "Environment name, such as dev or prod."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC IPv4 CIDR block."
  type        = string
}

variable "subnet_cidr" {
  description = "Public subnet IPv4 CIDR block."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "Trusted IPv4 CIDR allowed to SSH, usually YOUR_PUBLIC_IP/32."
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "allowed_ssh_cidr must be a valid IPv4 CIDR block."
  }
}
