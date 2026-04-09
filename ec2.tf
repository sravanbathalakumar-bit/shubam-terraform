# keypair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("terraform_key.pub")
}

# VPC & Security Group
resource "aws_default_vpc" "my_vpc" {
}

resource "aws_security_group" "my_security_group" {
  name        = "tf-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_default_vpc.my_vpc.id

  tags = {
    Name = "tf-sg"
  }
  #inbound rule for ssh
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Flask app"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
}
# Ec2 Instance
}
 resource aws_instance "my_ec2_instance" {
  ami           = "ami-0ffef61f6dc37ae89" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.my_security_group.name]

  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }

   tags = {
    Name = "My EC2 Instance"
  }
 }
  