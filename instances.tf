
resource "aws_instance" "bastion" {
    ami = "${var.bastion_ami}"
    instance_type = "t2.small"
    security_groups = ["${aws_security_group.bastion.id}"]
    subnet_id = "${aws_subnet.us-west-2a-public.id}"
    associate_public_ip_address = "true"
    key_name = "WaterShuriken"
    depends_on = ["aws_nat_gateway.gw"]
    
    tags {
        Name = "bastion.greninja.kordata"
        Environment = "Greninja"
        Category = "Kordata"
    }
}
