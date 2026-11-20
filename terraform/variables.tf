variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Resource naming prefix"
  type        = string
  default     = "portfolio-iac"
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,24}$", var.project_name))
    error_message = "project_name must be 3-25 lowercase letters, numbers or hyphens, starting with a letter."
  }
}

variable "vpc_cidr" {
  description = "VPC address range; default subnet plan assumes a /16 network"
  type        = string
  default     = "10.20.0.0/16"
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr)) && tonumber(split("/", var.vpc_cidr)[1]) == 16
    error_message = "vpc_cidr must be a valid IPv4 /16 CIDR for this example's subnet layout."
  }
}

variable "instance_type" {
  description = "EC2 instance size (x86_64 compatible with the AMI)"
  type        = string
  default     = "t3.micro"
}
