#Variables
variable "aws_region" {}

variable "aws_profile" {}

variable "vpc_cidr" {}

variable "public_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in web layer"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "web_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in web layer"
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "app_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in app layer"
  default     = ["10.0.31.0/24", "10.0.32.0/24"]
}

variable "db_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in DB layer"
  default     = ["10.0.41.0/24", "10.0.42.0/24"]
}

variable "sg_bastion_host" {
	type = list(number)
}

variable "privatekey" {}
