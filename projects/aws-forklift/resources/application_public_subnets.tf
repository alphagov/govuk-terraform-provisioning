resource "aws_subnet" "application_public_1" {
    vpc_id            = "${aws_vpc.aws_forklift.id}"
    cidr_block        = "192.168.221.0/24"
    availability_zone = "eu-west-1a"

    map_public_ip_on_launch = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}


resource "aws_subnet" "application_public_2" {
    vpc_id            = "${aws_vpc.aws_forklift.id}"
    cidr_block        = "192.168.222.0/24"
    availability_zone = "eu-west-1b"

    map_public_ip_on_launch = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}


resource "aws_subnet" "application_public_3" {
    vpc_id            = "${aws_vpc.aws_forklift.id}"
    cidr_block        = "192.168.223.0/24"
    availability_zone = "eu-west-1c"

    map_public_ip_on_launch = true

    tags {
        Name = "aws_forklift"
        team = "Infrastructure"
    }
}
