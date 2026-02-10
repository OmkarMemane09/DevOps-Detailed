# Define the AWS provider
provider "aws" {
  region = "us-east-1"   
}

# Create an EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-0ecb62995f68bb549" 
  instance_type = "t3.micro"  
  key_name = "nv" 


  provisioner "local-exec" {
    command = "touch abc.txt"            
  }
  provisioner "file" {
  source      = "apache2.sh"
  destination = "/home/ubuntu/apache2.sh"
  }
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("nv")
    host     = self.public_ip
  }
    provisioner "remote-exec" {
    inline = [
        "bash /home/ubuntu/apache2.sh",
        "touch remote.txt"
    ]
  }
  tags = {
    Name = "MyFirstEC2"
  }
}

