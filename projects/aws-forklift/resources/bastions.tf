module "bastion_hosts" {
    source = "github.com/deanwilson/tf_autoscaling_bastions"

    ami_id = "ami-f95ef58a"

    asg_subnet_ids = "${aws_subnet.bastion_private_1.id}"
    elb_subnet_ids = "${aws_subnet.bastion_public_1.id}"

    host_keys_bucket = "govuk-hostkeys-bucket-${var.environment}.bastion-hostkeys"

    region   = "eu-west-1"
    ssh_key_name = "laura_aws_forklift"
    stackname = "govuk-aws-forklift"

    vpc_id = "${aws_vpc.aws_forklift.id}"
}

resource "aws_s3_bucket" "govuk-hostkeys-bucket" {
    bucket = "govuk-hostkeys-bucket-${var.environment}"
}
