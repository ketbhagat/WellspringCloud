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

# Subnets
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

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds_subnet_name
  subnet_ids = [aws_subnet.db.*.id]
  tags {
    Name = "WSC-RDS"
  }
}

# Route Table for Public Layer
resource "aws_route_table" "public" {
	vpc_id = aws_vpc.main.id
	route{
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.main.id
	}
	tags = {
		Name = "WSC-Public"
	}
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets_cidr_blocks)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

# Elastic IP for NAT gateway
resource "aws_eip" "nat_eip" {
  vpc = true
  tags = {
    Name = "WSC-Nat-Gateway-IP"
  }
}

# NAT gateway to give private subnets to access to the outside world
resource "aws_nat_gateway" "main" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${element(aws_subnet.public.*.id, 0)}"

  tags = {
    Name = "WSC-NAT-GW"
  }
}

# Route Tables for Web Layer
resource "aws_route_table" "web" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags {
    Name = "WSC-Web"
  }
}

resource "aws_route_table_association" "web" {
  count          = "${length(var.web_subnets_cidr_blocks)}"
  subnet_id      = "${element(aws_subnet.web.*.id, count.index)}"
  route_table_id = "${aws_route_table.web.id}"
}

# Route Tables for App Layer

resource "aws_route_table" "app" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.main.id}"
  }
  tags {
    Name = "WSC-App"
  }
}

resource "aws_route_table_association" "app" {
  count          = "${length(var.app_subnets_cidr_blocks)}"
  subnet_id      = "${element(aws_subnet.app.*.id, count.index)}"
  route_table_id = "${aws_route_table.app.id}"
}

# Route Tables for DB Layer

resource "aws_route_table" "db" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.mian.id}"
  }
  tags {
    Name = "WSC-DB"
  }
}

resource "aws_route_table_association" "db" {
  count          = "${length(var.db_subnets_cidr_blocks)}"
  subnet_id      = "${element(aws_subnet.db.*.id, count.index)}"
  route_table_id = "${aws_route_table.db.id}"
}
