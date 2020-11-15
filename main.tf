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











resource "aws_security_group" "vanilla_ec2" {
	vpc_id = "vpc-0ff79b51c20ef8673"
	name = "vanilla-ec2-security-group"
  	description = "Allow inbound traffic for vanilla ec2 instance"
 
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "database_ec2" {
	vpc_id = "vpc-0ff79b51c20ef8673"
	name = "database-ec2-security-group"
  	description = "Allow inbound traffic for database ec2 instance"
  
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# rule to allow ssh from laptop to instance

resource "aws_security_group_rule" "ssh_from_laptop_to_vanilla_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["82.159.78.28/32"]
  
  security_group_id = aws_security_group.vanilla_ec2.id
}


resource "aws_security_group_rule" "ssh_from_laptop_to_database_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["82.159.78.28/32"]
  
  security_group_id = aws_security_group.database_ec2.id
}

# rule to allow ssh from instances to instances

resource "aws_security_group_rule" "ssh_from_database_to_vanilla_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.database_ec2.id
  
  security_group_id = aws_security_group.vanilla_ec2.id
}


resource "aws_security_group_rule" "ssh_from_vanilla_to_database_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.vanilla_ec2.id
  
  security_group_id = aws_security_group.database_ec2.id
}

# rule to allow icmp-ipv4 traffic from instances to instances

resource "aws_security_group_rule" "icmp_from_database_to_vanilla_ec2" {
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  source_security_group_id = aws_security_group.database_ec2.id
  
  security_group_id = aws_security_group.vanilla_ec2.id
}


resource "aws_security_group_rule" "icmp_from_vanilla_to_database_ec2" {
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  source_security_group_id = aws_security_group.vanilla_ec2.id
  
  security_group_id = aws_security_group.database_ec2.id
}














resource "aws_instance" "vanilla-ec2" {
  ami                         = "ami-0de12f76efe134f2f"
  instance_type               = "t2.micro"
  subnet_id                   = var.my_subnet_1
  vpc_security_group_ids      = [aws_security_group.vanilla_ec2.id]
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
