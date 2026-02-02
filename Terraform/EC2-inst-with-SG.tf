provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "example" {
  name = "securitygroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "securitygroup"
  }
}

resource "aws_instance" "web_server" {
  ami                    = "ami-019715e0d74f695be"
  instance_type          = "t2.nano"
  vpc_security_group_ids = [aws_security_group.example.id]

  tags = {
    Name = "terraform"
  }
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}
