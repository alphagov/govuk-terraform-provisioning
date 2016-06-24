resource "aws_vpc" "aws_forklift" {
    cidr_block = "192.168.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}


resource "aws_internet_gateway" "aws_forklift_igw" {
   vpc_id = "${aws_vpc.aws_forklift.id}"
}


resource "aws_route_table" "default_public" {
  vpc_id = "${aws_vpc.aws_forklift.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.aws_forklift_igw.id}"
  }
}
