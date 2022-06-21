#EC2 Instance
resource "aws_instance" "web" {
	ami = data.aws_ami.awslinux2.id
	instance_type = "t2.micro"
	subnet_id = aws_subnet.public_1a.id
	vpc_security_group_ids = [ aws_security_group.allow_tls.id ]
	user_data = <<EOF
		#!/bin/bash
		yum install httpd -y
		systemctl enable httpd --now
		echo "Welcome to the World of WellspringCloud" > /var/www/html/index.html
		EOF
	key_name = var.privatekey
	tags = {
		Name = "WSC-Web"
	}
	depends_on = [
		aws_security_group.allow_tls
	]
}
