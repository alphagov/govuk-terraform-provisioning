
resource "aws_security_group" "efg_elb" {
    name = "${var.elb_security_group_name}_${var.stackname}"
    description = "EFG ELB SG: ${var.elb_security_group_name}_${var.stackname}"

    vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "elb_ssh_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.efg_elb.id}"

    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${var.https_source_cidr_block}"]
}


resource "aws_security_group" "efg_app" {
    name = "${var.app_security_group_name}_${var.stackname}"
    description = "EFG Application SG: ${var.app_security_group_name}_${var.stackname}"

    vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "efg_app_ssh_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.efg_app.id}"

    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.ssh_source_cidr_block}"]
}

resource "aws_security_group_rule" "efg_app_http_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.efg_app.id}"

    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.efg_elb.id}"
}

resource "aws_security_group_rule" "efg_app_https_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.efg_app.id}"

    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.efg_elb.id}"
}

resource "aws_security_group_rule" "efg_app_everything_tcp_egress" {
    type = "egress"
    security_group_id = "${aws_security_group.efg_app.id}"

    from_port = 0
    to_port = 65335
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "efg_app_everything_udp_egress" {
    type = "egress"
    security_group_id = "${aws_security_group.efg_app.id}"

    from_port = 0
    to_port = 65335
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
}



resource "aws_security_group" "efg_rds" {
    name = "${var.rds_security_group_name}_${var.stackname}"
    description = "EFG RDS SG: ${var.rds_security_group_name}_${var.stackname}"

    vpc_id = "${aws_vpc.vpc.id}"
}


resource "aws_security_group_rule" "rds_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.efg_rds.id}"

    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.efg_app.id}"
}
