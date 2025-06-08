variable "region" {
  type        = string
  default     = "ap-southeast-1"
  description = "Region of VPC"
}

variable "vpc_ids" {
  type        = string
  description = "ID of VPC that Route Table will be created in"
  default     = "vpc-090e793b42ad6f18e"
}

variable "igw_ids" {
  type        = string
  description = "ID of Internet Gateway that Route Table will be created in"
  default     = "igw-0c800ca6e97200b13"
}

variable "nat-gateway_ids" {
  type        = string
  description = "ID of NAT Gateway that Route Table will be created in"
  default     = "nat-0ecc98814fe1566be"
}

variable "public_subnet_ids" {
  type        = string
  description = "ID of Public Subnet that Route Table will be created in"
  default     = "subnet-041510e8909031abd"
}

variable "private_subnet_ids" {
  type        = string
  description = "ID of Private Sutẻbnet that Route Table will be created in"
  default     = "subnet-03b33f082859af882"
}