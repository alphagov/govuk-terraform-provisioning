resource "template_file" "puppetmaster_user_data" {
    template = "${file("projects/aws-forklift/resources/templates/base-user-data.sh.tpl")}"

    vars {
        region       = "${var.aws_default_region}"
        puppet_role  = "puppetmaster"
    }
}


resource "aws_launch_configuration" "puppetmaster_lc" {
    name_prefix = "puppetmaster-lc-"
    # image_id = "${var.ami_id}"
    image_id = "ami-f95ef58a"

    # instance_type = "${var.instance_type}"
    instance_type = "t2.small"

    iam_instance_profile = "${aws_iam_instance_profile.base_profile.name}"
    key_name = "laura_aws_forklift"
    # key_name = "${var.ssh_key_name}"
    security_groups = ["${aws_security_group.puppetmaster.id}", "${aws_security_group.managed_host.id}"]

    user_data = "${template_file.puppetmaster_user_data.rendered}"

    lifecycle {
      create_before_destroy = true
    }
}


resource "aws_autoscaling_group" "puppetmaster_asg" {
    vpc_zone_identifier = ["${aws_subnet.management_private_1.id}"]

    name = "puppetmaster_asg_"
    launch_configuration = "${aws_launch_configuration.puppetmaster_lc.name}"

    max_size = "1"
    min_size = "1"

    tag {
        key = "terraform"
        value = "true"
        propagate_at_launch = true
    }

    tag {
        key = "Name"
        value = "puppetmaster-host"
        propagate_at_launch = true
    }

    lifecycle {
      create_before_destroy = true
    }
}
