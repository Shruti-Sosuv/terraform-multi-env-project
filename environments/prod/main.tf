terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "environment" {
  source = "../../modules/network-ec2"

  name             = "study-prod"
  environment      = "prod"
  vpc_cidr         = "10.20.0.0/16"
  subnet_cidr      = "10.20.1.0/24"
  instance_type    = var.instance_type
  allowed_ssh_cidr = var.allowed_ssh_cidr
}
