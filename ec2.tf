#EC2 Instance
resource "aws_instance" "bastion_host" {
	ami = data.aws_ami.awslinux2.id
	instance_type = "t2.micro"
	subnet_id = aws_subnet.public.id
	vpc_security_group_ids = [ aws_security_group.bastion_host.id ]
	user_data = <<EOF
		#!/bin/bash
		yum install httpd -y
		systemctl enable httpd --now
		echo "Welcome to the World of WellspringCloud" > /var/www/html/index.html
		EOF
	key_name = var.privatekey
	tags = {
		Name = "WSC-Bastion_Host"
	}
}
