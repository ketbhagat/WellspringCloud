#EC2 Instance
resource "aws_instance" "web" {
	ami = data.aws_ami.awslinux2.id
	instance_type = "t2.micro"
	tags = {
		Name = "WSC-Web"
	}
}
