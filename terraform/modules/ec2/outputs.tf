output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = { for idx, instance in aws_instance.ec2_instance : idx => instance.id }
}

output "instance_private_ips" {
  description = "The private IP addresses of the EC2 instances"
  value       = { for idx, instance in aws_instance.ec2_instance : idx => instance.private_ip }
}

output "instance_public_ips" {
  description = "The public IP addresses (Elastic IPs) of the EC2 instances (only if Elastic IPs are associated)"
  value       = { for idx, eip in aws_eip.elastic_ips : idx => eip.public_ip if contains(keys(aws_eip.elastic_ips), idx) }
}

output "elastic_ip_ids" {
  description = "The allocation IDs of the Elastic IPs"
  value       = { for idx, eip in aws_eip.elastic_ips : idx => eip.id }
}

output "eip_associations" {
  description = "The associations between Elastic IPs and instances"
  value       = { for idx, assoc in aws_eip_association.eip_association : idx => assoc.id }
}