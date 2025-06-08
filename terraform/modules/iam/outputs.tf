output "iam_role_arn" {
  description = "The ARN of the IAM role created for EC2 instances."
  value       = aws_iam_role.ec2_role.arn
}

output "iam_instance_profile_arn" {
  description = "The ARN of the IAM instance profile created for EC2 instances."
  value       = aws_iam_instance_profile.ec2_instance_profile.arn
}

output "iam_role_name" {
  description = "The name of the IAM role created for EC2 instances."
  value       = aws_iam_role.ec2_role.name
}

output "iam_instance_profile_name" {
  description = "The name of the IAM instance profile created for EC2 instances."
  value       = aws_iam_instance_profile.ec2_instance_profile.name
}
