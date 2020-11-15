terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  region  = "eu-west-3"
  access_key = var.my_public_key
  secret_key = var.my_secret_key
}



output "subnet_id_is" {
  value = var.my_subnet_1
}
 
output "security_group_chosen_is" {
  value = var.security_group_SSH_laptop
}

resource "aws_instance" "vanilla-ec2" {
  ami                         = "ami-0de12f76efe134f2f"
  instance_type               = "t2.micro"
  subnet_id                   = var.my_subnet_1
  vpc_security_group_ids      = [aws_security_group.instance_ec2.id]
  associate_public_ip_address = true
  user_data                   = file("user-data/ec2-vanilla-instance.sh")
  key_name                    = "key-pair-Linux-AMI-root"
  tags = {
    Name = "vanilla-ec2"
    Agent = "Jenkins"
    Terraform = "TRUE"
    Role = "App"
  }
}

resource "aws_instance" "database-ec2" {
  ami                         = "ami-0de12f76efe134f2f"
  instance_type               = "t2.micro"
  subnet_id                   = var.my_subnet_1
  vpc_security_group_ids      = [aws_security_group.database_ec2.id]
  associate_public_ip_address = true
  user_data                   = file("user-data/ec2-database-instance.sh")
  key_name                    = "key-pair-Linux-AMI-root"
  tags = {
    Name = "database-ec2"
    Agent = "Jenkins"
    Terraform = "TRUE"
    Role = "Database"
  }
}
