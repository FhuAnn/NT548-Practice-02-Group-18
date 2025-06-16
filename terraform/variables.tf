### Variables for VPC module
variable "region" {
  type        = string
  default     = "ap-southeast-1"
  description = "Region of VPC"
}

variable "bucket_name" {
  type        = string
  default     = "lab02-terraform-state-group18"
  description = "S3 bucket name for storing Terraform state files"
}

variable "vpc_cidr" {
  type        = string
  default     = "192.168.0.0/16"
  description = "CIDR block for VPC"
}

variable "public_subnet_cidr" {
  type        = list(string)
  default     = ["192.168.1.0/24"]
  description = "CIDR block for Public Subnets"
}

variable "private_subnet_cidr" {
  type        = list(string)
  default     = ["192.168.2.0/24"]
  description = "CIDR block for Private Subnets"
}

### Variables for Security Group module
variable "cidr_block" {
  description = "Public IP from Internet that has permission to access the EC2 instance in public subnet"
  type        = string
  default     = "14.169.43.244/32"
}

### Variables for EC2 module
variable "instances_configuration" {
  type = list(object({
    count         = number
    ami           = string
    instance_type = string
    root_block_device = object({
      volume_size = number
      volume_type = string
    })
    tags                   = map(string)
    vpc_security_group_ids = list(string)
    subnet_id              = string
    user_data_file         = optional(string, null) #path to user_data file
    key_name               = string
    associate_elastic_ip   = bool
    iam_instance_profile   = optional(string, null) # instance in private subnet does not need public IP
  }))

  default = [{
    count         = 1 # number of instances that has the same configuration
    ami           = "ami-069cb3204f7a90763" # os image
    instance_type = "t2.micro" # instance type
    root_block_device = {
      volume_size = 8 # volume size
      volume_type = "gp2" # volume type 
    }
    tags = {
      Name = "public-instance" # instance name
    }
    vpc_security_group_ids = null 
    subnet_id              = null 
    user_data_file         = "user-data.sh" # user data file name
    key_name               = "lab02-keypair-group18" # ssh key pair name
    associate_elastic_ip   = true # need assign elastic ip or not
    iam_instance_profile   = "ec2-role-instance-profile" # name of iam instance profile
    },
    {
      count         = 1 # number of instances that has the same configuration
      ami           = "ami-069cb3204f7a90763" # os image
      instance_type = "t2.micro" # instance type
      root_block_device = {
        volume_size = 8 # volume size
        volume_type = "gp2" # volume type
      }
      tags = {
        Name = "private-instance" # instance name
      }
      vpc_security_group_ids = null 
      subnet_id              = null
      user_data_file         = null # user data file name - null = no user data
      key_name               = "lab02-keypair-group18" # ssh key pair name
      associate_elastic_ip   = false # need assign elastic ip or not
      iam_instance_profile   = null # name of iam instance profile - null = no iam instance profile
  }]
}