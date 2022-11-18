# Terraform
#
# Create simple server with nginx, mysql & wordpress  
#
# Made by Aleksandr Vishnevskiy

provider "aws" {
  region                   = "eu-central-1"
  shared_credentials_files = ["C:/Users/Admin/.aws/credentials"]
  profile                  = "Aleksandr"
}

resource "aws_instance" "nginx" {
  ami                    = "ami-0caef02b518350c8b"  # Ubuntu 
  instance_type          = "t2.micro"
  key_name               = "Frankfurt-vish"
  vpc_security_group_ids = [aws_security_group.nginx_access.id]
  user_data              = file("user_data.sh")
  tags = {
    Name = "Nginx"
  }
}

resource "aws_security_group" "nginx_access" {
  name = "Nginx access group"
  dynamic "ingress" {
    for_each = ["80", "8080", "3306", "22"]
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
    Name = "Nginx"
  }
}

output "public_ip" {
  value = aws_instance.nginx.public_ip
}
