resource "aws_security_group" "managed_host" {
    name = "managed_host"
    description = "managed_host_sg"
    vpc_id = "${aws_vpc.aws_forklift.id}"
}


resource "aws_security_group_rule" "bastion_ssh_ingress" {
    type = "ingress"
    security_group_id = "${aws_security_group.managed_host.id}"

    from_port = 22
    to_port = 22
    protocol = "tcp"
    source_security_group_id = "${module.bastion_hosts.bastion_security_group_id}"
}

resource "aws_security_group_rule" "puppet_agent_egress" {
    type = "egress"
    security_group_id = "${aws_security_group.managed_host.id}"

    from_port = 8140
    to_port = 8140
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.puppetmaster.id}"
}
