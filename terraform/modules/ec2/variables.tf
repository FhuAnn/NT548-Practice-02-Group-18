variable "subnet_id" {
  description = "Subnet ID to launch the EC2 instance in"
  type        = string
}
variable "sg_id" {
  description = "Security Group ID to attach to the EC2 instance"
  type        = string
}

variable "ami_id" {
  type    = string
  default = "ami-003ce501eabea4d72" 
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}