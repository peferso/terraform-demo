
variable "my_subnet_1" {
  type        = string
  description = "The public subnet 1 in VPC"
  default     = "no_subnet_value_found"
}

variable "security_group_SSH_laptop" {
  type        = set(string)
  description = "The security group ID that allows ssh from my home's IP"
  default     = ["no_securiy_group_found"]
}

variable "my_secret_key" {
  type        = string
}

variable "my_public_key" {
  type        = string
}
