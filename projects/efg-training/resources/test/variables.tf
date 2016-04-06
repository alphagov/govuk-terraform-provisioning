variable "app_name" {
    default = "efg-training"
}

variable "region" {
    default = "eu-west-1"
}

variable "stackname" {
    default = "20160406"
}

variable "ssh_key_name" {
    default = "" # FIXME:
}

variable "elb_security_group_name" {
    default = "efg-training-elb"
}

variable "app_security_group_name" {
    default = "efg-training"
}

variable "rds_security_group_name" {
    default = "efg-training-rds"
}

variable "https_source_cidr_block" {
    default = "0.0.0.0/0"
}

variable "ssh_source_cidr_block" {
    default = "0.0.0.0/0"
}

variable "vpc_cidr" {
    default = "172.31.0.0/16"
}

variable "max_efg_app_instances" {
    default = 1
}

variable "min_efg_app_instances" {
    default = 1
}

variable "efg_app_instance_type" {
    default = "t2.medium"
}



################ FIXME: find a way to iterate in more cases.

variable "availability_zones" {
    default = {
        eu-west-1 = "eu-west-1a,eu-west-1b"
    }
}

variable "efg_az_1" {
    default = "eu-west-1a"
}

variable "efg_az_2" {
    default = "eu-west-1b"
}

################### CIDR Ranges
variable "efg_public_1_cidr" {
    default = "172.31.11.0/24"
}
variable "efg_public_2_cidr" {
    default = "172.31.12.0/24"
}
variable "efg_app_1_cidr" {
    default = "172.31.21.0/24"
}
variable "efg_app_2_cidr" {
    default = "172.31.22.0/24"
}
variable "efg_rds_1_cidr" {
    default = "172.31.31.0/24"
}
variable "efg_rds_2_cidr" {
    default = "172.31.32.0/24"
}



variable "ami_id" {
    default = {
        eu-west-1 = "ami-bfa319cc"
    }
}
