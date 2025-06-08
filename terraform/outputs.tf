# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc_module.vpc_id
}

# Output the Public Subnet IDs
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc_module.public_subnet_id
}

# Output the Private Subnet IDs
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.vpc_module.private_subnet_id
}

# Output the Internet Gateway ID
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc_module.igw_id
}

# Output the VPC CIDR block
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc_module.vpc_cidr_block
}

# Output the CIDR blocks for the subnets
output "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
  value       = module.vpc_module.public_subnet_cidr
}

output "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
  value       = module.vpc_module.private_subnet_cidr
}

# Output the NAT Gateway ID
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.nat_gateway_module.nat_gateway_id
}

# Output the Public Route Table ID
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = module.route_table_module.public_route_table_id
}

# Output the Private Route Table ID
output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = module.route_table_module.private_route_table_id
}

# Output Security group
output "public_ssh-sg_id" {
  description = "The ID of the Public SSH Security Group"
  value       = module.security_group_module.public_ssh-sg_id
}

output "private_ssh-sg_id" {
  description = "The ID of the Private SSH Security Group"
  value       = module.security_group_module.private_ssh-sg_id
}

# Output the EC2 instance IDs from the ec2_module
output "instance_ids" {
  description = "The IDs of the EC2 instances from the ec2_module"
  value       = module.ec2_module.instance_ids
}

# Output the private IP addresses of the EC2 instances from the ec2_module
output "instance_private_ips" {
  description = "The private IP addresses of the EC2 instances from the ec2_module"
  value       = module.ec2_module.instance_private_ips
}

# Output the public IP addresses (Elastic IPs) of the EC2 instances from the ec2_module
output "instance_public_ips" {
  description = "The public IP addresses of the EC2 instances (Elastic IPs) from the ec2_module"
  value       = module.ec2_module.instance_public_ips
}

# Output the allocation IDs of the Elastic IPs from the ec2_module
output "elastic_ip_ids" {
  description = "The allocation IDs of the Elastic IPs from the ec2_module"
  value       = module.ec2_module.elastic_ip_ids
}

# Output the Elastic IP associations from the ec2_module
output "eip_associations" {
  description = "The associations between Elastic IPs and instances from the ec2_module"
  value       = module.ec2_module.eip_associations
}