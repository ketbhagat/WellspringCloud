#Security Group
resource "aws_security_group" "bastion_host" {
	name = "WSC-bastion_host"
	description = "Allow SSH inbound traffic"
	vpc_id = aws_vpc.main.id

	dynamic "ingress" {
		for_each = var.sg_bastion_host
		iterator = port
		content {
			description = "SSH from VPC"
			from_port =  port.value
			to_port =  port.value
			protocol = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}
	egress {
		from_port = 0
		to_port = 0
		protocol         = "-1"
		cidr_blocks      = ["0.0.0.0/0"]
	}
	tags = {
		Name = "WSC-bastion_host"
	}
}

resource "aws_security_group" "weblb" {
	name = "WSC-WebLB"
	description = "Allow http inbound traffic"
	vpc_id = aws_vpc.main.id

	dynamic "ingress" {
		for_each = var.sg_weblb
		iterator = port
		content {
			description = "HTTP from VPC"
			from_port =  port.value
			to_port =  port.value
			protocol = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}
	egress {
		from_port = 0
		to_port = 0
		protocol         = "-1"
		cidr_blocks      = ["0.0.0.0/0"]
	}
	tags = {
		Name = "WSC-WebLB"
	}
}


resource "aws_security_group" "webserver" {
	name = "WSC-WebServer"
	description = "Allow http inbound traffic"
	vpc_id = aws_vpc.main.id

	dynamic "ingress" {
		for_each = var.sg_webserver
		iterator = port
		content {
			description = "HTTP from VPC"
			from_port =  port.value
			to_port =  port.value
			protocol = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}
	egress {
		from_port = 0
		to_port = 0
		protocol         = "-1"
		cidr_blocks      = ["0.0.0.0/0"]
	}
	tags = {
		Name = "WSC-WebServer"
	}
}

resource "aws_security_group" "appserver" {
	name = "WSC-AppServer"
	description = "Allow http inbound traffic"
	vpc_id = aws_vpc.main.id

	dynamic "ingress" {
		for_each = var.sg_appserver
		iterator = port
		content {
			description = "TLS from VPC"
			from_port =  port.value
			to_port =  port.value
			protocol = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}
	egress {
		from_port = 0
		to_port = 0
		protocol         = "-1"
		cidr_blocks      = ["0.0.0.0/0"]
	}
	tags = {
		Name = "WSC-AppServer"
	}
}

resource "aws_security_group" "db" {
	name = "WSC-DB"
	description = "Allow 3306 inbound traffic"
	vpc_id = aws_vpc.main.id

	dynamic "ingress" {
		for_each = var.sg_db
		iterator = port
		content {
			description = "TLS from VPC"
			from_port =  port.value
			to_port =  port.value
			protocol = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}
	egress {
		from_port = 0
		to_port = 0
		protocol         = "-1"
		cidr_blocks      = ["0.0.0.0/0"]
	}
	tags = {
		Name = "WSC-DB"
	}
}
