#AWS VPC
resource "aws_vpc" "main" {
	cidr_block = var.vpc_cidr
	tags = {
		Name = "WSC-VPC"
	}
}

resource "aws_internet_gateway" "main" {
	vpc_id = aws_vpc.main.id
	tags = {
		Name = "WSC-IGW"
	}
}

resource "aws_subnet" "public_1a" {
	vpc_id = aws_vpc.main.id
	cidr_block = var.subnet_public_1a
	availability_zone = var.subnet_public_1a_az
	map_public_ip_on_launch = true
	tags = {
		Name = "WSC-Public-1a"
	}
}

resource "aws_subnet" "public_1b" {
	vpc_id = aws_vpc.main.id
	cidr_block = var.subnet_public_1b
	availability_zone = var.subnet_public_1b_az
	map_public_ip_on_launch = true
	tags = {
		Name = "WSC-Public-1b"
	}
}

resource "aws_subnet" "private_1a" {
	vpc_id = aws_vpc.main.id
	cidr_block = var.subnet_private_1a
	availability_zone = var.subnet_private_1a_az
	map_public_ip_on_launch = true
	tags = {
		Name = "WSC-Private-1a"
	}
}

resource "aws_subnet" "private_1b" {
	vpc_id = aws_vpc.main.id
	cidr_block = var.subnet_private_1b
	availability_zone = var.subnet_private_1b_az
	map_public_ip_on_launch = true
	tags = {
		Name = "WSC-Private-1b"
	}
}

resource "aws_route_table" "rt_public" {
	vpc_id = aws_vpc.main.id
	route{
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.main.id
	}
	tags = {
		Name = "WSC-Public-RT"
	}
}

resource "aws_route_table_association" "rt_public_1a_assoc" {
	subnet_id = aws_subnet.public_1a.id
	route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "rt_public_1b_assoc" {
	subnet_id = aws_subnet.public_1b.id
	route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table" "rt_private" {
	vpc_id = aws_vpc.main.id
	tags = {
		Name = "WSC-Private-RT"
	}
}

resource "aws_route_table_association" "rt_private_1a_assoc" {
	subnet_id = aws_subnet.private_1a.id
	route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_private_1b_assoc" {
	subnet_id = aws_subnet.private_1b.id
	route_table_id = aws_route_table.rt_private.id
}
