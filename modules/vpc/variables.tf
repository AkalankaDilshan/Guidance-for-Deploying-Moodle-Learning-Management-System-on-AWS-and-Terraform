variable "vpc_name" {
  type        = string
  description = "name for the main vpc"
}

variable "cidr_block" {
  type        = string
  description = "range of ip addresses that in vpc"
}

variable "availability_zones" {
  type        = list(string)
  description = "availability zones list"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "cidr values for public subnet"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "cidr values for private subnet"
}

variable "private_data_subnet_cidrs" {
  type        = list(string)
  description = "cidr values for private data subnet"
}
