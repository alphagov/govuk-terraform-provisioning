# Create a VPC to launch our instances into
resource "aws_vpc" "govuk-training" {
  cidr_block         = "172.30.0.0/16"
  enable_dns_support = true
  tags {
    Name = "govuk-training"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "govuk-training_aws_internet_gateway" {
  vpc_id = "${aws_vpc.govuk-training.id}"
  tags {
    Name = "govuk-training"
  }
}

# Create a public subnet to launch our instances into
resource "aws_subnet" "govuk-training_aws_subnet_public" {
  vpc_id                  = "${aws_vpc.govuk-training.id}"
  cidr_block              = "172.30.1.0/24"
  map_public_ip_on_launch = true
  tags {
    Name = "govuk-training-public"
  }
}

# Output public subnet
output "public_subnet_ids" {
  value = "${aws_subnet.govuk-training_aws_subnet_public.id}"
}

# Grant the VPC internet access on its route table
resource "aws_route_table" "govuk-training_aws_route_table_public" {
  vpc_id = "${aws_vpc.govuk-training.id}"
  tags {
    Name = "govuk-training"
  }
}

resource "aws_route_table_association" "govuk-training_aws_route_table_association_public" {
  subnet_id      = "${aws_subnet.govuk-training_aws_subnet_public.id}"
  route_table_id = "${aws_route_table.govuk-training_aws_route_table_public.id}"
}

resource "aws_route" "govuk-training_aws_route_internet" {
  route_table_id         = "${aws_route_table.govuk-training_aws_route_table_public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.govuk-training_aws_internet_gateway.id}"
}

# Our default security group for public instances
resource "aws_security_group" "govuk-training_aws_security_group_public_base" {
  name        = "govuk-training_aws_security_group_public_base"
  description = "Base rules for public instances"
  vpc_id      = "${aws_vpc.govuk-training.id}"
  tags {
    Name = "govuk-training_sg_public_base"
  }
}

# HTTPS access from the VPC
resource "aws_security_group_rule" "govuk-training_aws_security_group_rule_in_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.govuk-training_aws_security_group_public_base.id}"
}

# SSH access from the corporate IPs
resource "aws_security_group_rule" "govuk-training_aws_security_group_rule_in_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["31.210.245.102/32","80.194.77.90/32","85.133.67.244/32","213.86.153.212/32","213.86.153.213/32","213.86.153.214/32","213.86.153.235/32","213.86.153.236/32","213.86.153.237/32"]
  security_group_id = "${aws_security_group.govuk-training_aws_security_group_public_base.id}"
}

# Outbound internet access
resource "aws_security_group_rule" "govuk-training_aws_security_group_rule_out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.govuk-training_aws_security_group_public_base.id}"
}

output "public_security_group_ids" {
  value = "${aws_security_group.govuk-training_aws_security_group_public_base.id}"
}

#resource "aws_key_pair" "govuk-training_aws_key_pair" {
#  key_name   = "${var.key_name}"
#  public_key = "${file(var.public_key_path)}"
#}

# DNS zone
resource "aws_route53_zone" "govuk-training_zone" {
  name = "training.publishing.service.gov.uk."
}

output "route53_zone_id" {
  value = "${aws_route53_zone.govuk-training_zone.zone_id}"
}

