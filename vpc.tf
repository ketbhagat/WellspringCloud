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

resource "aws_subnet" "public" {
	count             = "${length(var.public_subnets_cidr_blocks)}"
	vpc_id            = "${aws_vpc.main.id}"
	availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
	cidr_block        = "${var.public_subnets_cidr_blocks[count.index]}"
	map_public_ip_on_launch = true
	tags = {
		Name = "WSC-Public-${count.index}"
	}
}

resource "aws_subnet" "web" {
	count             = "${length(var.web_subnets_cidr_blocks)}"
	vpc_id            = "${aws_vpc.main.id}"
	availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
	cidr_block        = "${var.web_subnets_cidr_blocks[count.index]}"
	tags = {
		Name = "WSC-Web-${count.index}"
	}
}

resource "aws_subnet" "app" {
	count             = "${length(var.app_subnets_cidr_blocks)}"
	vpc_id            = "${aws_vpc.main.id}"
	availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
	cidr_block        = "${var.app_subnets_cidr_blocks[count.index]}"
	tags = {
		Name = "WSC-App-${count.index}"
	}
}

resource "aws_subnet" "db" {
	count             = "${length(var.db_subnets_cidr_blocks)}"
	vpc_id            = "${aws_vpc.main.id}"
	availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
	cidr_block        = "${var.db_subnets_cidr_blocks[count.index]}"
	tags = {
		Name = "WSC-DB-${count.index}"
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
