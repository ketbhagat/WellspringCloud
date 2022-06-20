#Data Source
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
