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

module "SecurityGroups" {
  source = "./Modules/SecurityGroups"
}

module "EC2Database" {
  source = "./Modules/EC2Database"
  ec2SubNt = var.my_subnet_1
  secGrpID = module.SecurityGroups.serverEC2SecGrID
}
  
module "EC2Vanilla" {
  source = "./Modules/EC2Vanilla"
  ec2SubNt = var.my_subnet_1
  secGrpID = module.SecurityGroups.vanillaEC2SecGrID
}
