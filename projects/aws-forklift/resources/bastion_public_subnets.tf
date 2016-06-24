resource "aws_subnet" "bastion_public_1" {
    vpc_id            = "${aws_vpc.aws_forklift.id}"
    cidr_block        = "192.168.1.0/24"
    availability_zone = "eu-west-1a"

    map_public_ip_on_launch = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}


resource "aws_subnet" "bastion_public_2" {
    vpc_id            = "${aws_vpc.aws_forklift.id}"
    cidr_block        = "192.168.2.0/24"
    availability_zone = "eu-west-1b"

    map_public_ip_on_launch = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}


resource "aws_subnet" "bastion_public_3" {
    vpc_id            = "${aws_vpc.aws_forklift.id}"
    cidr_block        = "192.168.3.0/24"
    availability_zone = "eu-west-1c"

    map_public_ip_on_launch = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}
