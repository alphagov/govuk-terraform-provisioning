
resource "aws_elb" "efg_elb" {
    # availability_zones = ["${split(",", lookup(var.availability_zones, var.region))}"]
    subnets = ["${aws_subnet.efg_public_1.id}", "${aws_subnet.efg_public_1.id}"]

    cross_zone_load_balancing = true
    security_groups = ["${aws_security_group.efg_elb.id}"]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    listener { # FIXME: needs a cert arn before you can make it https
        instance_port = 80
        instance_protocol = "http"
        lb_port = 443
        lb_protocol = "http"
    }

    health_check { # FIXME: Revise to be realistic
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTPS:443/"
        interval = 30
    }

    tags {
        Name = "${var.app_name}-${var.stackname}-elb"
        terraform = "true"
        stackname = "${var.stackname}"
    }

}
