

resource "aws_instance" "nginx" {
    ami = "${var.nginx_ami}"
    instance_type = "t2.small"
    security_groups = ["${aws_security_group.web.id}"]
    subnet_id = "${aws_subnet.us-west-2a-public.id}"
    associate_public_ip_address = "true"
    user_data = "${file("user-data/nginx_user_data.txt")}"
    depends_on = ["aws_nat_gateway.gw"]
    tags {
        Name = "SHEDINJA.nginx"
    }
}

 resource "aws_instance" "sync_gateway" {
     ami = "${var.sync_gateway_ami}"
     instance_type = "t2.small"
     security_groups = ["${aws_security_group.private.id}"]
     subnet_id = "${aws_subnet.us-west-2a-private.id}"
     associate_public_ip_address = "false"
     depends_on = ["aws_nat_gateway.gw"]
     tags {
         Name = "SHEDINJA.sync-gateway"
     }
 }

 resource "aws_instance" "docmosis" {
     ami = "${var.docmosis_ami}"
     instance_type = "t2.small"
     security_groups = ["aws_security_group.private.id"]
     subnet_id = "${aws_subnet.us-west-2a-private.id}"
     associate_public_ip_address = "false"
     depends_on = ["aws_nat_gateway.gw"]
     tags {
         Name = "SHEDINJA.docmosis"
     }
 }