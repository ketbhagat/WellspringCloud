#Variables
variable "aws_region" {}

variable "aws_profile" {}

variable "vpc_cidr" {}

variable "subnet_public_1a" {}

variable "subnet_public_1a_az" {}

variable "subnet_public_1b" {}

variable "subnet_public_1b_az" {}

variable "subnet_private_1a" {}

variable "subnet_private_1a_az" {}

variable "subnet_private_1b" {}

variable "subnet_private_1b_az" {}

variable "sg_ports" {
	type = list(number)
}

variable "privatekey" {}
