resource "null_resource" "localinventory" {
	triggers = {
		current = timestamp()
	}
	provisioner "local-exec" {
	    command = "echo ${aws_instance.os1.tags.Name} ansible_host=${aws_instance.os1.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=/root/xyz.pem>> inventory"
	}
	depends_on = [ 
		aws_instance.os1 
	]
}

