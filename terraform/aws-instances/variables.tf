variable "subnet_id" {
  type = "string"
}

variable "instance_type" {
  type = "string"
}

# Ubuntu Precise 14.04 LTS (x64)
variable "aws_amis" {
  type = "map"
  default = {
    ap-southeast-1 = "ami-25c00c46"
    eu-west-1 = "ami-TODO"
    us-east-1 = "ami-TODO"
    us-west-1 = "ami-TODO"
    us-west-2 = "ami-TODO"
  }
}

variable "aws_region" {
  type = "string"
}

variable "key_name" {
  type = "string"
}

variable "default_security_group_id" {
  type = "string"
}

variable "security_group_icmp" {
  type = "string"
}

variable "security_group_www" {
  type = "string"
}

variable "security_group_bastion" {
  type = "string"
}