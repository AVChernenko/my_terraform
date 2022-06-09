#----------------------------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#
# Made by 
#----------------------------------------------------------


provider "aws" {}
  


resource "aws_instance" "my_webserver" {
  ami                    = "ami-09d56f8956ab235b3"
  instance_type          = "t2.micro"
  key_name = "useast1"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = file("user_data.sh")

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Alex"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "my_webserver" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "22", "9092", "9093"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SecurityGroup"
    Owner = "Alex"
  }
}
