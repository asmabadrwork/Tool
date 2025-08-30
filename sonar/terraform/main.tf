provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "sonarqube" {
  ami           = "ami-0f58b397bc5c1f2e8" # Ubuntu 22.04 LTS in ap-south-1
  instance_type = "t3.medium"
  key_name      = "sonarqube-key"

  tags = {
    Name = "SonarQube_Server"
  }
}
