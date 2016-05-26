resource "aws_subnet" "efg_public_1" {
    vpc_id            = "${aws_vpc.vpc.id}"
    cidr_block        = "${var.efg_public_1_cidr}"
    availability_zone = "${var.efg_az_1}"

    map_public_ip_on_launch = true

    tags {
        Name = "${var.app_name}_${var.efg_az_1}-elb"
        team = "Infrastructure"
        terraform = "true"
    }
}

resource "aws_route_table_association" "efg_public_1_rta" {
    subnet_id = "${aws_subnet.efg_public_1.id}"
    route_table_id = "${aws_route_table.default_public.id}"
}


resource "aws_subnet" "efg_public_2" {
    vpc_id            = "${aws_vpc.vpc.id}"
    cidr_block        = "${var.efg_public_2_cidr}"
    availability_zone = "${var.efg_az_2}"

    map_public_ip_on_launch = true

    tags {
        Name = "${var.app_name}_${var.efg_az_2}-elb"
        team = "Infrastructure"
        terraform = "true"
    }
}

resource "aws_route_table_association" "efg_public_2_rta" {
    subnet_id = "${aws_subnet.efg_public_2.id}"
    route_table_id = "${aws_route_table.default_public.id}"
}
