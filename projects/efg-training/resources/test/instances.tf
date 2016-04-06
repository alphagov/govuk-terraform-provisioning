
resource "aws_launch_configuration" "efg_app_lc" {
    name_prefix = "efg-app-lc-${var.stackname}-"
    image_id = "${lookup(var.ami_id, var.region)}"

    instance_type = "${var.efg_app_instance_type}"

    # FIXME: once we chose what it needs
    # iam_instance_profile = "${aws_iam_instance_profile.bastion_profile.name}"
    key_name = "${var.ssh_key_name}"
    security_groups = ["${aws_security_group.efg_elb.id}"]

    # FIXME: once we chose what it needs
    # user_data = "${template_file.user_data.rendered}"

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "efg_app_asg" {
    # FIXME: remove variable if not needed now we're in vpc
    # availability_zones = ["${split(",", lookup(var.availability_zones, var.region))}"]

    vpc_zone_identifier = ["${aws_subnet.efg_app_2.id}", "${aws_subnet.efg_app_2.id}"]

    name = "${var.app_name}-${var.stackname}"
    launch_configuration = "${aws_launch_configuration.efg_app_lc.name}"
    load_balancers = ["${aws_elb.efg_elb.name}"]

    max_size = "${var.max_efg_app_instances}"
    min_size = "${var.min_efg_app_instances}"

    tag {
        key = "terraform"
        value = "true"
        propagate_at_launch = true
    }

    tag {
        key = "Name"
        value = "${var.app_name}-${var.stackname}-efg-app"
        propagate_at_launch = true
    }

    tag {
        key = "stackname"
        value = "${var.stackname}"
        propagate_at_launch = true
    }

    lifecycle {
      create_before_destroy = true
    }
}
