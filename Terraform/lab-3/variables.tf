variable "environment" {
  type        = string
  description = "Deployment env name"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be dev, stage, or prod."
  }
}

variable "aws_region" {
  type        = string
  description = "Enter region name"
  default = "eu-central-1"
}
