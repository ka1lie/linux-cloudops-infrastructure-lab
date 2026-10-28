variable "environment" {
  type        = string
  description = "Deployment env name"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be dev, stage, or prod."
  }
}


variable "vpc_subnet" {
  type = string
  description = "Ender your VPC subnet address with CIRD: "
  default = "10.42.0.0/16"
}

variable "public_subnet" {
  type = string
  description = "Ender your public subnet address with CIRD: "
  default = "10.42.10.0/24"
}

variable "private_subnet" {
  type = string
  description = "Ender your private subnet address with CIRD: "
  default = "10.42.20.0/24"
}

variable "aws_AZ_region" {
  type        = string
  description = "Network AZ region name"
}

variable "aws_region" {
  type        = string
  description = "Enter region name"
}

variable "client_cidr" {
  type = string
  description = "Type Client CIDR"
}