resource "aws_subnet" "efg_app_1" {
    vpc_id            = "${aws_vpc.vpc.id}"
    cidr_block        = "${var.efg_app_1_cidr}"
    availability_zone = "${var.efg_az_1}"

    tags {
        Name = "${var.app_name}_${var.efg_az_1}-app"
        team = "Infrastructure"
        terraform = "true"
    }
}

resource "aws_route_table_association" "efg_app_1_rta" {
    subnet_id = "${aws_subnet.efg_app_1.id}"
    route_table_id = "${aws_route_table.default_public.id}"
}

resource "aws_subnet" "efg_app_2" {
    vpc_id            = "${aws_vpc.vpc.id}"
    cidr_block        = "${var.efg_app_2_cidr}"
    availability_zone = "${var.efg_az_2}"

    tags {
        Name = "${var.app_name}_${var.efg_az_2}-app"
        team = "Infrastructure"
        terraform = "true"
    }
}

resource "aws_route_table_association" "efg_app_2_rta" {
    subnet_id = "${aws_subnet.efg_app_2.id}"
    route_table_id = "${aws_route_table.default_public.id}"
}
