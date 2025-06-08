provider "aws" {
  region = var.region
}

locals {
  project_name = "lab1-group13"
}

#---------------------------------------------------------------#
#----------------- Create 1 VPC with 2 subnets -----------------#
#---------------------------------------------------------------#

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${local.project_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  count      = length(var.public_subnet_cidr)
  cidr_block = element(var.public_subnet_cidr, count.index)
  tags = {
    Name = "${local.project_name}-public-subnet"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  count      = length(var.private_subnet_cidr)
  cidr_block = element(var.private_subnet_cidr, count.index + 1)

  tags = {
    Name = "${local.project_name}-private-subnet"
  }
}

#---------------------------------------------------------------#
#------------------ Create 1 Internet Gateway ------------------#
#--------------------- Attach IGW to VPC -----------------------#
#---------------------------------------------------------------#

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.project_name}-igw"
  }
}

#---------------------------------------------------------------#
#---------------- Create Default Security Group ----------------#
#---------------------------------------------------------------#

resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-default-sg"
  }
}