resource "aws_instance" "database" {

  tags = {
    Name = "database"
  }

  subnet_id = "${var.subnet_id}"

  ami = "${lookup(var.aws_amis, var.aws_region)}"

  instance_type = "${var.instance_type}"

  key_name = "${var.key_name}"

  vpc_security_group_ids = [
    // vpc default
    "${var.default_security_group_id}"
    ]

}
