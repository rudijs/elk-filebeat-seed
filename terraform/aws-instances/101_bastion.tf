resource "aws_instance" "bastion" {

  tags = {
    Name = "bastion"
  }

  subnet_id = "${var.subnet_id}"

  ami = "${lookup(var.aws_amis, var.aws_region)}"

  instance_type = "${var.instance_type}"

  key_name = "${var.key_name}"

  vpc_security_group_ids = [
    // vpc default
    "${var.default_security_group_id}",
    // ingress
    "${var.security_group_icmp}",
    "${var.security_group_bastion}",
    "${var.security_group_www}"
    // egress
    // "${var.security_group_egress}"
    ]

  // enable NAT
  source_dest_check = false

  connection {
    # The default username for our AMI
    user = "ubuntu"
    # The connection will use the local SSH agent for authentication.
  }

  # Enable NAT
  // provisioner "remote-exec" {
  //   script = "terraform/aws-instances/bastion_nat_rules.sh"
  // }

  provisioner "file" {
    source = "terraform/aws-instances/bastion_nat_rules.sh"
    destination = "/home/ubuntu/bastion_nat_rules.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /home/ubuntu/bastion_nat_rules.sh"
    ]
  }

  # apt-get update the box, install ntp, reboot
  // user_data = "${file("terraform/aws-instances/user_data.yml")}"

}
