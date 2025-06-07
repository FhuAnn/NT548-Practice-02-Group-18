resource "aws_instance" "ec2" {
  ami           = "ami-003ce501eabea4d72"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  metadata_options {
    http_tokens = "required"
    http_endpoint = "enabled"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "Terraform-EC2"
  }
}
