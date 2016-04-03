output "subnet_id" {
  value = "${aws_subnet.public.id}"
}

output "default_security_group_id" {
  value = "${aws_vpc.default.default_security_group_id}"
}

output "security_group_icmp" {
  value = "${aws_security_group.icmp_SG.id}"
}

output "security_group_bastion" {
  value = "${aws_security_group.bastion_SG.id}"
}

output "security_group_www" {
  value = "${aws_security_group.www_SG.id}"
}
