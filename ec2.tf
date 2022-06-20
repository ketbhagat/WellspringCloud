#EC2 Instance
resource "aws_instance" "web" {
	ami = data.aws_ami.awslinux2.id
	instance_type = "t2.micro"
	subnet_id = aws_subnet.public_1a.id
	security_groups = ["allow_tls"]
	key_name = var.privatekey
	tags = {
		Name = "WSC-Web"
	}
}
