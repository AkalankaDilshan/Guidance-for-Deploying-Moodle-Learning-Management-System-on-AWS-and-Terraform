variable "subnet_ids" {
  description = "list of subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "desired_capacity" {
  description = "Minimum number of instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of instance"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instance"
  type        = number
  default     = 4
}

variable "target_group_arns" {
  description = "List of target group ARNs"
  type        = list(string)
  default     = []
}

