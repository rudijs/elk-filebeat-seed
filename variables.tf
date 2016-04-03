# export TF_VAR_aws_access_key=xxx-xxx-xxx-xxx
variable "aws_access_key" {
  type = "string"
}

# export TF_VAR_aws_secret_key=xxx-xxx-xxx-xxx
variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type = "string"
  description = "AWS region to launch servers."
  default = "ap-southeast-1"
}

variable "key_name" {
  type = "string"
  default = "amazon-vpc-singapore"
}

variable "instance_type" {
  type = "string"
  default = "t2.micro"
}

// see aws-instances module for these config defaults
// https://github.com/hashicorp/terraform/issues/1336
// variable "aws_amis" {
//   type = "map"
// }