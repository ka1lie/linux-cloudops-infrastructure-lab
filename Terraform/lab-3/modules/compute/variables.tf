variable "aws_region" {
  type        = string
  description = "Region name"
}

variable "environment" {
  type        = string
  description = "Deployment env name"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be dev, stage, or prod."
  }
}

variable "server_type" {
  type = string
  description = "EC2 Instance type"
  default = "t3.small"
}

variable "subnet_public_id" {
  type = string
  description = "VPC public subnet ID"
}

variable "sg_id" {
  type = string
  description = "Security Group id"
}