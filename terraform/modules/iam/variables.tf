variable "region" {
  type        = string
  default     = "ap-southeast-1"
  description = "Region of IAM role"  
}

variable "role_name" {
  type        = string
  description = "The name of the IAM role to create."
  default     = "ec2-role"
}

variable "secret_arns" {
  type        = list(string)
  description = "List of ARNs for the secrets that this role can access."
  default     = ["arn:aws:secretsmanager:ap-southeast-1:381492301125:secret:ssh_key-SOIegK"] 
}
