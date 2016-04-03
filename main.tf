provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

module "aws_vpc" {
  source = "./terraform/aws-vpc"
}

module "aws_instances" {
  source = "./terraform/aws-instances"
  
  subnet_id = "${module.aws_vpc.subnet_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  aws_region = "${var.aws_region}"
  default_security_group_id = "${module.aws_vpc.default_security_group_id}"
  security_group_icmp = "${module.aws_vpc.security_group_icmp}"
  security_group_www = "${module.aws_vpc.security_group_www}"
  security_group_bastion = "${module.aws_vpc.security_group_bastion}"
}
