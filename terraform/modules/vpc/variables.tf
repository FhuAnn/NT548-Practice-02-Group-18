variable "region" {
  type        = string
  default     = "ap-southeast-1"
  description = "Region of VPC"
}

variable "vpc_cidr" {
  type        = string
  default     = "192.168.0.0/16"
  description = "CIDR block for VPC"
}

variable "public_subnet_cidr" {
  type        = list(string)
  default     = ["192.168.1.0/24"]
  description = "CIDR block for Public Subnets"
}

variable "private_subnet_cidr" {
  type        = list(string)
  default     = ["192.168.2.0/24"]
  description = "CIDR block for Private Subnets"
}