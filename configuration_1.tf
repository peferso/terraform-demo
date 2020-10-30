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
  profile = "user1"
}


output "subnet_id_is" {
  value = var.my_subnet_1
}
 
output "security_group_chosen_is" {
  value = var.security_group_SSH_laptop
}

resource "aws_instance" "example" {
  ami                         = "ami-0de12f76efe134f2f"
  instance_type               = "t2.micro"
  subnet_id                   = var.my_subnet_1
  vpc_security_group_ids      = var.security_group_SSH_laptop
  associate_public_ip_address = true
  user_data                   = "file('script_user_data_1.sh')"
  key_name                    = "key-pair-Linux-AMI-root"
  tags = {
    Name = "InsUserData-Terraform"
  }
}