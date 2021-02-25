# ================================================================================ #
#                       main.tf file of: EC2Vanilla Module 
#   This template creates an EC2 instance configured to act as a MySQL client.
# -------------------------------------------------------------------------------- #
# EC2database Module: input variables
# -------------------------------------------------------------------------------- #
# * Declared in <<variables.tf>> file in Module´s folder.
# -------------------------------------------------------------------------------- #
# Mandatory:
#   ec2SubNt (string)
#   secGrpID (string)
# Optional:
#   amiType (string)
#   insType (string)
#   pathToUD (string)
#   publicIP (logical)
#   keyName (string)
# ================================================================================ #
# EC2database Module: output variables
# -------------------------------------------------------------------------------- #
# * Declared in <<outputs.tf>> file in Module´s folder.
# -------------------------------------------------------------------------------- #
# insID (string)
# insPublicIP (string)
# insPublicDNS (string)
# insState (string)
# ================================================================================ #

resource "aws_instance" "vanilla_ec2" {
  ami                         =  var.amiType
  instance_type               =  var.insType
  subnet_id                   =  var.ec2SubNt
  vpc_security_group_ids      = [var.secGrpID]
  associate_public_ip_address =  var.publicIP
  user_data                   =  file(var.pathToUD)
  key_name                    =  var.keyName
  tags = {
    Name = join("-", [var.environmentName, "vanilla_ec2"])
    Environment = var.environmentName
    Agent = "Jenkins"
    Terraform = "TRUE"
    Role = "Client"
  }
}
