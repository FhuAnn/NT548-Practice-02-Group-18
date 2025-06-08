# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

# Output the Public Subnet IDs
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet[*].id
}

# Output the Private Subnet IDs
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private_subnet[*].id
}

# Output the Internet Gateway ID
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# # Output the Security Group ID
# output "default_security_group_id" {
#   description = "The ID of the default security group"
#   value       = aws_default_security_group.default-sg.id
# }

# Output the VPC CIDR block
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.vpc.cidr_block
}

# Output the CIDR blocks for the subnets
output "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
  value       = aws_subnet.public_subnet[*].cidr_block
}

output "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
  value       = aws_subnet.private_subnet[*].cidr_block
}