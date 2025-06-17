provider "aws" {
  region = var.region
}

locals {
  project_name = "lab2-group18"
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

# # Thêm Flow Logging cho VPC - trivy fix
# resource "aws_flow_log" "vpc_flow_log" {
#   log_destination      = aws_cloudwatch_log_group.vpc_flow_log.arn # Hoặc S3 ARN nếu bạn muốn lưu vào S3
#   traffic_type         = "ALL" # Ghi lại tất cả lưu lượng (ingress và egress)
#   vpc_id               = aws_vpc.vpc.id
#   log_destination_type = "cloud-watch-logs" # Hoặc "s3" nếu bạn muốn lưu vào S3
#   deliver_logs_permission_arn = aws_iam_role.vpc_flow_logs_role.arn # IAM Role cho Flow Logs
# # }

# # Tạo Log Group nếu sử dụng CloudWatch - trivy fix
# resource "aws_cloudwatch_log_group" "vpc_flow_log" {
#   name = "/aws/vpc/flow-logs/${local.project_name}-vpc"
#   retention_in_days = 30 # Thời gian lưu trữ log (có thể thay đổi)
# }


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
    from_port = 0
    to_port   = 0
    cidr_blocks = [] #trivy fix
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []#trivy fix
  }

  tags = {
    Name = "${local.project_name}-default-sg"
  }
}