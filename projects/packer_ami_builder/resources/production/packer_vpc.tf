
resource "aws_vpc" "ami_builder_vpc" {
    cidr_block = "192.168.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Name = "ami_builder_vpc"
        team = "Infrastructure"
    }
}


resource "aws_internet_gateway" "ami_builder_vpc_igw" {
  vpc_id = "${aws_vpc.ami_builder_vpc.id}"
}


resource "aws_route_table" "default_public" {
  vpc_id = "${aws_vpc.ami_builder_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ami_builder_vpc_igw.id}"
  }
}


resource "aws_subnet" "ami_builder_1a" {
    vpc_id            = "${aws_vpc.ami_builder_vpc.id}"
    cidr_block        = "192.168.1.0/24"
    availability_zone = "eu-west-1a"

    map_public_ip_on_launch = true

    tags {
        Name = "ami_builder_vpc_subnet_1a"
        team = "Infrastructure"
    }
}

resource "aws_route_table_association" "ami_builder_1a_rta" {
  subnet_id = "${aws_subnet.ami_builder_1a.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}


resource "aws_subnet" "ami_builder_1b" {
    vpc_id            = "${aws_vpc.ami_builder_vpc.id}"
    cidr_block        = "192.168.2.0/24"
    availability_zone = "eu-west-1b"

    map_public_ip_on_launch = true

    tags {
        Name = "ami_builder_vpc_subnet_1b"
        team = "Infrastructure"
    }
}

resource "aws_route_table_association" "ami_builder_1b_rta" {
  subnet_id = "${aws_subnet.ami_builder_1b.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
