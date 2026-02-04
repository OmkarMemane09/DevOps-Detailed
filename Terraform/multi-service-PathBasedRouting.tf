
provider "aws" {
  region = "ap-south-1"
}


resource "aws_launch_template" "home-temp" {
  name          = "home-temp"
  image_id      = "ami-019715e0d74f695be"
  instance_type = "t3.micro"

  # Security group allowing HTTP
  vpc_security_group_ids = ["sg-0f1f87164247bbd1d"]

  # User data installs nginx and serves HOME page
  user_data = base64encode(<<EOF
#!/bin/bash
apt update -y
apt install nginx -y
echo "<h1>Welcome to Home</h1>" > /var/www/html/index.html
systemctl start nginx
systemctl enable nginx
EOF
  )

  tags = {
    Name = "home-template"
  }
}


resource "aws_launch_template" "cloth-temp" {
  name          = "cloth-temp"
  image_id      = "ami-019715e0d74f695be"
  instance_type = "t3.micro"

  vpc_security_group_ids = ["sg-0f1f87164247bbd1d"]

  # Creates /cloth directory (needed for path routing)
  user_data = base64encode(<<EOF
#!/bin/bash
apt update -y
apt install nginx -y
mkdir -p /var/www/html/cloth
echo "<h1>SALE SALE SALE</h1>" > /var/www/html/cloth/index.html
systemctl start nginx
systemctl enable nginx
EOF
  )

  tags = {
    Name = "cloth-template"
  }
}


resource "aws_launch_template" "laptop-temp" {
  name          = "laptop-temp"
  image_id      = "ami-019715e0d74f695be"
  instance_type = "t3.micro"

  vpc_security_group_ids = ["sg-0f1f87164247bbd1d"]

  # FIXED: laptop directory was missing earlier
  user_data = base64encode(<<EOF
#!/bin/bash
apt update -y
apt install nginx -y
mkdir -p /var/www/html/laptop
echo "<h1>Laptops are also in Discount</h1>" > /var/www/html/laptop/index.html
systemctl start nginx
systemctl enable nginx
EOF
  )

  tags = {
    Name = "laptop-template"
  }
}


resource "aws_lb_target_group" "home-tg" {
  name     = "home-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id  = "vpc-014dba4a8175e8ea4"
}

resource "aws_lb_target_group" "cloth-tg" {
  name     = "cloth-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id  = "vpc-014dba4a8175e8ea4"
}

resource "aws_lb_target_group" "laptop-tg" {
  name     = "laptop-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id  = "vpc-014dba4a8175e8ea4"
}


resource "aws_autoscaling_group" "home-asg" {
  name                 = "home-asg"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  health_check_type    = "ELB"
  availability_zones   = ["ap-south-1a","ap-south-1b","ap-south-1c"]

  target_group_arns = [aws_lb_target_group.home-tg.arn]

  launch_template {
    id      = aws_launch_template.home-temp.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "cloth-asg" {
  name               = "cloth-asg"
  min_size           = 1
  max_size           = 3
  desired_capacity   = 1
  health_check_type  = "ELB"
  availability_zones = ["ap-south-1a","ap-south-1b","ap-south-1c"]

  target_group_arns = [aws_lb_target_group.cloth-tg.arn]

  launch_template {
    id      = aws_launch_template.cloth-temp.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "laptop-asg" {
  name               = "laptop-asg"
  min_size           = 1
  max_size           = 3
  desired_capacity   = 1
  health_check_type  = "ELB"
  availability_zones = ["ap-south-1a","ap-south-1b","ap-south-1c"]

  target_group_arns = [aws_lb_target_group.laptop-tg.arn]

  launch_template {
    id      = aws_launch_template.laptop-temp.id
    version = "$Latest"
  }
}


resource "aws_lb" "myalb" {
  name               = "myalb"
  load_balancer_type = "application"
  internal           = false

  security_groups = ["sg-0f1f87164247bbd1d"]
  subnets = [
    "subnet-01a9ce37f5353bcb0",
    "subnet-0041314f731e8acdc",
    "subnet-05017d4c75a329e95"
  ]
}


resource "aws_lb_listener" "home-list" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  # Default route → HOME
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.home-tg.arn
  }
}


resource "aws_lb_listener_rule" "cloth-rule" {
  listener_arn = aws_lb_listener.home-list.arn
  priority     = 1

  condition {
    path_pattern {
      values = ["/cloth*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cloth-tg.arn
  }
}


resource "aws_lb_listener_rule" "laptop-rule" {
  listener_arn = aws_lb_listener.home-list.arn
  priority     = 2

  condition {
    path_pattern {
      values = ["/laptop*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.laptop-tg.arn
  }
}
