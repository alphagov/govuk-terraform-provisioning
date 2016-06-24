resource "aws_security_group" "puppetmaster" {
    name = "puppetmaster"
    description = "puppetmaster_sg"
    vpc_id = "${aws_vpc.aws_forklift.id}"
}


resource "aws_security_group_rule" "puppet_agent_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.puppetmaster.id}"

    from_port = 8140
    to_port = 8140
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.managed_host.id}"
}
