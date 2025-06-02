variable "asg_name" {
  description = "Auto scaling Group name"
  type        = string
}

variable "scale_up_adjustment" {
  description = "Number of instances to scale up by"
  type        = number
  default     = 1
}

variable "scale_down_adjustment" {
  description = "Number of instances to scale down by"
  type        = number
  default     = -1
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
