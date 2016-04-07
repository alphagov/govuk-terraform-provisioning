# Packer templates for building machine images

Set environment variables for `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

You will need to pass the vpc_id and the subnet_id on the command line.

The VPC and SUBNET are created with this terraform manifest:  
[/projects/packer_ami_builder/resources/production/packer_vpc.tf]
(../projects/packer_ami_builder/resources/production/packer_vpc.tf)

Run `packer build -var 'vpc_id=1234567' -var 'subnet_id=1234567' ami.json` from this directory.
