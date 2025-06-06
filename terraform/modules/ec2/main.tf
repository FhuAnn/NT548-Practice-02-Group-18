resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = "Terraform-EC2"
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
}
