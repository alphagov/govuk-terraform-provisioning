resource "aws_subnet" "application_private_1" {
    vpc_id            = "${aws_vpc.aws_forklift.id}"
    cidr_block        = "192.168.201.0/24"
    availability_zone = "eu-west-1a"

    map_public_ip_on_launch = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}


resource "aws_subnet" "application_private_2" {
    vpc_id            = "${aws_vpc.aws_forklift.id}"
    cidr_block        = "192.168.202.0/24"
    availability_zone = "eu-west-1b"

    map_public_ip_on_launch = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}


resource "aws_subnet" "application_private_3" {
    vpc_id            = "${aws_vpc.aws_forklift.id}"
    cidr_block        = "192.168.203.0/24"
    availability_zone = "eu-west-1c"

    map_public_ip_on_launch = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}
