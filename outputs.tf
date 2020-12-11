# + Outputs from EC2Database Module
#   - insID (string)
#   - insPublicIP (string)
#   - insPublicDNS (string)
#   - insState (string)

output "EC2Database_insID" {
  description = "ID of the database EC2 instance"
  value       = module.EC2Database.insID
}
output "EC2Database_insPublicIP" {
  description = "Public IP of the database EC2 instance"
  value       = module.EC2Database.insPublicIP
}
output "EC2Database_insPrivateIP" {
  description = "Private IP of the database EC2 instance"
  value       = module.EC2Database.insPrivateIP
}
output "EC2Database_insPublicDNS" {
  description = "Public DNS of the database EC2 instance"
  value       = module.EC2Database.insPublicDNS
}
output "EC2Database_insState" {
  description = "State of the database EC2 instance"
  value       = module.EC2Database.insState
}

# + Outputs from SecurityGroups Module
#   - clientEC2SecGrID (string)
#   - serverEC2SecGrID (string)

output "secGroup_clientEC2" {
  description = "ID of vanilla EC2 security group"
  value       = module.SecurityGroups.clientEC2SecGrID
}

output "secGroup_serverEC2" {
  description = "ID of database EC2 security group"
  value       = module.SecurityGroups.serverEC2SecGrID
}
