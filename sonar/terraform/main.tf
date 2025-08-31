provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube-sg"
  description = "Allow SSH, HTTP, and Jenkins traffic"
  vpc_id      = "vpc-0be3cb4c3eed1d260" # <-- replace with your default VPC ID

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # or restrict to Jenkins server IP
  }

  ingress {
    description = "SonarQube Web UI"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom App Port (8000)"
    from_port   = 8000
    to_port     = 8000
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
    Name = "SonarQube_SG"
  }
}

resource "aws_instance" "sonarqube" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t3.medium"
  key_name      = "sonarqube-key"

  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]

  tags = {
    Name = "SonarQube_Server"
  }
}
