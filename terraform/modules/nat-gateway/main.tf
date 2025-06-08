provider "aws" {
  region = var.region
}

locals {
  project_name = "lab02-group8"
}

#---------------------------------------------------------------#
#--------------------- Create 1 NAT Gateway --------------------#
#-------------------- Attach to Public Subnet ------------------#
#---------------------------------------------------------------#
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.subnet_ids
  tags = {
    Name = "${local.project_name}-natgw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  # depends_on = [aws_internet_gateway.igw]
}