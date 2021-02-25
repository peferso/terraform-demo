# ================================================================================ #
#                       main.tf file of: root Module 
#   This template creates:
#              1. Security groups used by 2 EC2 instances.
#              2. An EC2 instance configured to act as a MySQL server.
# -------------------------------------------------------------------------------- #
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  region  = var.my_region
  access_key = var.my_public_key
  secret_key = var.my_secret_key
}

resource "aws_vpc" "environments_vpc" {
  cidr_block = "10.20.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "Environments vpc"
  }
}

resource "aws_subnet" "subnet1" {
  depends_on = [
    aws_vpc.environments_vpc
  ]
  vpc_id = aws_vpc.environments_vpc.id
  cidr_block = "10.20.1.0/24"
  availability_zone = "eu-west-3b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public subnet1-Environments vpc"
  }
}

resource "aws_vpc_peering_connection" "peering_orchestrator_and_environment_vpcs" {
  peer_vpc_id   = aws_vpc.environments_vpc.id
  vpc_id        = var.my_vpc_id
  auto_accept   = true
  tags = {
    Name = "VPC peering between orchestrator and Environments VPCs"
  }
}

resource "aws_internet_gateway" "vpc_IGW" {
  depends_on = [
    aws_vpc.environments_vpc,
    aws_subnet.subnet1
  ]
  vpc_id = aws_vpc.environments_vpc.id
}

resource "aws_route_table" "Public-Subnet-RT" {
  depends_on = [
    aws_vpc.environments_vpc,
    aws_internet_gateway.vpc_IGW
  ]
  vpc_id = aws_vpc.environments_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_IGW.id
  }

  route {
    cidr_block = "10.10.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_orchestrator_and_environment_vpcs.id
  }

  tags = {
    Name = "Route Table for vpc Internet Gateway"
  }
}

resource "aws_route" "r" {
  route_table_id            = "rtb-0d26983a12b5a2283"
  destination_cidr_block    = "10.20.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_orchestrator_and_environment_vpcs.id
#  depends_on                = [aws_route_table.testing]
}

resource "aws_route_table_association" "RT-IG-Association" {
  depends_on = [
    aws_vpc.environments_vpc,
    aws_subnet.subnet1,
    aws_route_table.Public-Subnet-RT
  ]
  subnet_id      = aws_subnet.subnet1.id 
  route_table_id = aws_route_table.Public-Subnet-RT.id
}

resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.RT-IG-Association
  ]
  vpc = true
}

resource "aws_nat_gateway" "Nat-Gateway" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  subnet_id      = aws_subnet.subnet1.id 
  tags = {
    Name = "Nat-Gateway_Environments"
  }
}

resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.Nat-Gateway
  ]
  vpc_id = aws_vpc.environments_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Nat-Gateway.id
  }
  tags = {
    Name = "Route Table for NAT Gateway"
  }
}

resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

module "SecurityGroups" {
  source = "./Modules/SecurityGroups"
  vpcID = aws_vpc.environments_vpc.id
}

module "EC2Database" {
  source = "./Modules/EC2Database"
  ec2SubNt = aws_subnet.subnet1.id
  secGrpID = module.SecurityGroups.serverEC2SecGrID
  environmentName = var.environmentName
}
  
module "EC2Vanilla" {
  source = "./Modules/EC2Vanilla"
  ec2SubNt = aws_subnet.subnet1.id
  secGrpID = module.SecurityGroups.clientEC2SecGrID
  environmentName = var.environmentName
}
