resource "aws_subnet" "efg_rds_1" {
    vpc_id            = "${aws_vpc.vpc.id}"
    cidr_block        = "${var.efg_rds_1_cidr}"
    availability_zone = "${var.efg_az_1}"

    tags {
        Name = "${var.app_name}_${var.efg_az_1}-rds"
        team = "Infrastructure"
        terraform = "true"
    }
}

resource "aws_route_table_association" "efg_rds_1_rta" {
    subnet_id = "${aws_subnet.efg_rds_1.id}"
    route_table_id = "${aws_route_table.default_public.id}"
}


resource "aws_subnet" "efg_rds_2" {
    vpc_id            = "${aws_vpc.vpc.id}"
    cidr_block        = "${var.efg_rds_2_cidr}"
    availability_zone = "${var.efg_az_2}"

    tags {
        Name = "${var.app_name}_${var.efg_az_2}-rds"
        team = "Infrastructure"
        terraform = "true"
    }
}

resource "aws_route_table_association" "efg_rds_2_rta" {
    subnet_id = "${aws_subnet.efg_rds_2.id}"
    route_table_id = "${aws_route_table.default_public.id}"
}


resource "aws_db_subnet_group" "efg_rds" {
    name = "${var.app_name}-${var.stackname}"
    description = "EFG RDS Subnet group"
    subnet_ids = ["${aws_subnet.efg_rds_1.id}", "${aws_subnet.efg_rds_2.id}"]

    tags {
        Name = "EFG ${var.app_name}-${var.stackname} RDS subnet group"
        team = "Infrastructure"
        terraform = "true"
    }
}
