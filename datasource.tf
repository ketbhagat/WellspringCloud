#Data Source
data "aws_availability_zones" "available" {}

data "aws_ami" "awslinux2" {
	most_recent = true
	owners = ["amazon"]
	filter {
		name   = "name"
		values = ["amzn2-ami-*-gp2"]
	}
	filter {
		name   = "root-device-type"
		values = ["ebs"]
	}
	filter {
		name   = "virtualization-type"
		values = ["hvm"]
	}
	filter {
		name   = "architecture"
		values = ["x86_64"]
	}
}

data "aws_ami" "windows" {
	most_recent = true
	owners = ["amazon"]
	filter {
		name   = "name"
		values = ["Microsoft Windows Server 2019 Base"]
	}
	filter {
		name   = "root-device-type"
		values = ["ebs"]
	}
	filter {
		name   = "virtualization-type"
		values = ["hvm"]
	}
	filter {
		name   = "architecture"
		values = ["x86_64"]
	}
}
