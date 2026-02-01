provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "webapp" {
  name = "clo835-webapp"
}

resource "aws_ecr_repository" "mysql" {
  name = "clo835-mysql"
}

resource "aws_instance" "ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  key_name = "vockey"

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  iam_instance_profile = "LabInstanceProfile"  # ← added line

  tags = {
    Name = "clo835-ec2"
  }
}

resource "aws_security_group" "ec2_sg" {
  name = "clo835-sg"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8081
    to_port = 8083
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
