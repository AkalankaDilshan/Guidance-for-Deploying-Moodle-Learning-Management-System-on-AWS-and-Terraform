variable "vpc_id" {
  type        = string
  description = "TD for vpc"
}

variable "alb_name" {
  type        = string
  description = "name for Application Load Balancer"
}

variable "alb_subner_id" {
  type        = list(string)
  description = "id for alb subnets"
}

variable "security_group_id" {
  type        = string
  description = "application load balancer security group id"
}

variable "health_check_path" {
  type        = string
  description = "path for health check"
  default     = "/"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids for NAT gateway"
}

variable "load_balancer_type" {
  type        = string
  description = "lb type like application, network etc"
  default     = "application"
}

variable "target_group_type" {
  type        = string
  description = "the type for target group"
}

variable "target_ids" {
  type        = list(string)
  description = "List of target ids"
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB"
  type        = bool
  default     = false
}
