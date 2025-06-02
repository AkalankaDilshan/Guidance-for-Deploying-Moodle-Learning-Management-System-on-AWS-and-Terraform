variable "asg_name" {
  description = "Auto scaling Group name"
  type        = string
}

variable "scale_up_adjustment" {
  description = "Number of instances to scale up by"
  type        = number
  default     = 1
  validation {
    condition     = var.scale_up_adjustment > 0
    error_message = "Scale up adjustment must be positive."
  }
}

variable "scale_down_adjustment" {
  description = "Number of instances to scale down by"
  type        = number
  default     = -1
  validation {
    condition     = var.scale_down_adjustment < 0
    error_message = "Scale down adjustment must be negative."
  }
}

variable "high_cpu_threshold" {
  description = "CPU threshold for scaling up"
  type        = number
  default     = 70
}

variable "low_cpu_threshold" {
  description = "CPU threshold for scaling down"
  type        = number
  default     = 30
}
