resource "aws_security_group" "smartanswers_elb" {
    name = "smartanswers_elb_security_group_name"
    description = "smart_answers ELB SG"
    vpc_id = "${aws_vpc.aws_forklift.id}"
}


resource "aws_security_group_rule" "smartanswers_elb_https_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.smartanswers_elb.id}"

    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "smartanswers_elb_http_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.smartanswers_elb.id}"

    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_https_egress" {
    type = "egress"
    security_group_id = "${aws_security_group.smartanswers_elb.id}"

    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.smartanswers.id}"
}

resource "aws_security_group_rule" "elb_http_egress" {
    type = "egress"
    security_group_id = "${aws_security_group.smartanswers_elb.id}"

    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.smartanswers.id}"
}




resource "aws_security_group" "smartanswers" {
    name = "smartanswers_security_group_name"
    description = "smartanswers_security_group"
    vpc_id = "${aws_vpc.aws_forklift.id}"
}

resource "aws_security_group_rule" "smartanswers_https_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.smartanswers.id}"

    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.smartanswers_elb.id}"
}

resource "aws_security_group_rule" "smartanswers_http_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.smartanswers.id}"

    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.smartanswers_elb.id}"
}


resource "aws_security_group_rule" "smartanswers_everything_egress" {
    type = "egress"
    security_group_id = "${aws_security_group.smartanswers.id}"

    from_port = 0
    to_port = 65335
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
