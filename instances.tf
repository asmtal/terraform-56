
resource "aws_instance" "bastion" {
    ami = "${var.bastion_ami}"
    instance_type = "m4.large"
    security_groups = ["${aws_security_group.bastion.id}"]
    subnet_id = "${aws_subnet.us-west-2a-public.id}"
    associate_public_ip_address = "true"
    key_name = "PemKeyName"
    depends_on = ["aws_nat_gateway.gw"]
    tenancy = "dedicated"
    tags {
        Name = "bastion.environment.name"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}

resource "aws_instance" "backup" {
    ami = "ami-XXXXXXXXXX"
    instance_type = "m4.large"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    subnet_id = "${aws_subnet.us-west-2a-private.id}"
    key_name = "PemKeyName"
    tenancy = "dedicated"
    tags {
        Name = "backup.environment.name"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}