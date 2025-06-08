output "public_ssh-sg_id" {
  description = "The ID of the Public SSH Security Group"
  value       = aws_security_group.public_ssh-sg.id
}

output "private_ssh-sg_id" {
  description = "The ID of the Private SSH Security Group"
  value       = aws_security_group.private_ssh-sg.id
}