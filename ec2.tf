#EC2 Instance
resource "aws_instance" "bastion_host" {
	count = "${length(var.web_subnets_cidr_blocks)}"
	ami = data.aws_ami.awslinux2.id
	instance_type = "t2.micro"
	subnet_id = "${element(aws_subnet.web.*.id,count.index)}"
	vpc_security_group_ids = [ aws_security_group.bastion_host.id ]
	user_data = <<EOF
		#!/bin/bash
		yum install httpd -y
		systemctl enable httpd --now
		echo "Welcome to the World of WellspringCloud" > /var/www/html/index.html
		EOF
	key_name = var.privatekey
	tags = {
		Name = "${element(WSC-Bastion_Host,count.index)}"
	}
}
