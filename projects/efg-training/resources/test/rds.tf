
variable "rds_storage_size" {
    default = 5
}

variable "rds_instance_type" {
    default = "db.t2.medium"
}

resource "aws_db_instance" "default" {
    allocated_storage    = "${var.rds_storage_size}"
    apply_immediately    = false
    engine               = "mysql"
    engine_version       = "5.6.27"
    instance_class       = "${var.rds_instance_type}"
    identifier           = "${var.app_name}-${var.stackname}" # FIXME: Supposed to be optional. it's not.
    multi_az             = true
    name                 = "efg"
    username             = "efg"
    password             = "efgefgefgefgefg"
    db_subnet_group_name = "${aws_db_subnet_group.efg_rds.name}"
    parameter_group_name = "default.mysql5.6"
    vpc_security_group_ids = ["${aws_security_group.efg_rds.id}"]

    tags {
        Name = "${var.app_name}_rds"
        team = "Infrastructure"
        terraform = "true"
    }
}
