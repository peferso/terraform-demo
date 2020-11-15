resource "aws_security_group" "vanilla_ec2" {
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

