variable "region" {
  type        = string
  default     = "ap-southeast-1"
  description = "Region of EC2"
}

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

  default = [
  {
    count         = 1
    ami           = "ami-069cb3204f7a90763"
    instance_type = "t2.micro"
    root_block_device = {
      volume_size = 8
      volume_type = "gp2"
    }
    tags = {
      Name = "public-instance"
    }
    vpc_security_group_ids = ["sg-081bf0aadcfcca9c2"]
    subnet_id              = "subnet-0c43575fa4fd70b30"
    user_data_file         = "user-data.sh"
    key_name               = "lab02-keypair-group18"
    associate_elastic_ip   = true
    iam_instance_profile   = "ec2-role-instance-profile"
  }, # ✅ dấu phẩy đúng chỗ, sau object
  {
    count         = 1
    ami           = "ami-069cb3204f7a90763"
    instance_type = "t2.micro"
    root_block_device = {
      volume_size = 8
      volume_type = "gp2"
    }
    tags = {
      Name = "private-instance"
    }
    vpc_security_group_ids = ["sg-09101a2bfc271c21c"]
    subnet_id              = "subnet-00a06d04695510eb3"
    user_data_file         = null
    key_name               = "lab02-keypair-group18"
    associate_elastic_ip   = false
    iam_instance_profile   = null
  }
]
}
