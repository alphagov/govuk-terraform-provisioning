
resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Name = "${var.app_name}_vpc"
        team = "Infrastructure"
        terraform = "true"
    }
}


resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}


resource "aws_route_table" "default_public" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_igw.id}"
  }
}

