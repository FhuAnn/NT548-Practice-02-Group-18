resource "aws_instance" "example" {
  ami           = "ami-002e99de5ef075652" # Amazon Linux 2 (us-east-1)
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

output "public_ip" {
  value = aws_instance.example.public_ip
}
