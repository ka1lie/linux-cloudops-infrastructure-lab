variable "port" {
    type = number
    description = "Network port"
    default = 8080
    validation {
        condition = var.port >= 1 && var.port <= 65535
        error_message = "Port should be from 1 to 65535"
    }
}

variable "environment" {
  type        = string
  description = "Deployment env name"

  validation {
    condition     = contains(["dev", "stage"], var.environment)
    error_message = "Environment must be dev or stage."
  }
}