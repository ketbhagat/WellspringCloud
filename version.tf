#Terraform
terraform {
	required_version = "1.2.3"
	required_providers {
		wellspringcloud = {
			source  = "registry.terraform.io/hashicorp/aws"
			version = "~> 4.19"
		}
	}
}
