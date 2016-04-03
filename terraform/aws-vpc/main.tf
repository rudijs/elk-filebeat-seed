# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
    cidr_block = "10.0.0.0/16"
    tags {
        Name = "default"
    }
    enable_dns_hostnames = true
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "main-IGW"
  }
}

# Create a public subnet to launch bastion and www instances into
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags {
    Name = "public_SN"
  }
}

# Create a public route table
resource "aws_route_table" "public_RT" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "public_RT"
  }
}

# Associate the public route table to the public subnet
resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public_RT.id}"
}

# Grant the VPC internet access on its main route table
# Create a route from the public subnet to the internet
resource "aws_route" "internet_access" {
  // route_table_id         = "${aws_vpc.default.main_route_table_id}"
  route_table_id         = "${aws_route_table.public_RT.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a private subnet for databases
resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.2.0/24"
  tags {
    Name = "private_SN"
  }
}

# Create a private route table
resource "aws_route_table" "private_RT" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "private_RT"
  }
}

# Associate the private route table to the private subnet
resource "aws_route_table_association" "private" {
  subnet_id = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private_RT.id}"
}

resource "aws_security_group" "egress_SG" {
  name = "egress_SG"
  description = "Egress security group"
  tags {
    Name = "egress_SG"
  }
  vpc_id = "${aws_vpc.default.id}"

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "bastion_SG" {
  name = "bastion_SG"
  description = "Bastion security group"
  tags {
    Name = "bastion_SG"
  }
  vpc_id = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # VPN access from anywhere
  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "www_SG" {
  name = "www_SG"
  description = "WWW security group"
  tags {
    Name = "www_SG"
  }
  vpc_id = "${aws_vpc.default.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "icmp_SG" {
  name = "icmp_SG"
  description = "PING security group"
  tags {
    Name = "icmp_SG"
  }
  vpc_id = "${aws_vpc.default.id}"

  # PING access from anywhere
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}