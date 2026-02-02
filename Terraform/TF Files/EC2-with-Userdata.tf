provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0f58b397bc5c1f2e8" 
  instance_type = "t2.nano"

  vpc_security_group_ids = ["sg-0f1f87164247bbd1d"]

  user_data = <<EOF
#!/bin/bash
apt update -y
apt install -y nginx
systemctl enable nginx
systemctl start nginx
echo "Hello Im Omkar" > /var/www/html/index.html
EOF

#   user_data = base64encode(<<EOF
# #!/bin/bash
# apt update -y
# apt install -y nginx
# systemctl enable nginx
# systemctl start nginx
# echo "Hello Im Omkar" > /var/www/html/index.html
# EOF
# )
  tags = {
    Name = "terraform"
  }
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}
