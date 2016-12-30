resource "aws_security_group" "bastion" {
    name = "greninja_bastion_secgroup"
    description = "Allow incoming HTTP connections."

 ingress {
        from_port = 1775
        to_port = 1775
        protocol = "tcp"
        cidr_blocks = ["66.232.90.178/32"]
    }
 ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["66.232.90.178/32"]
    }
egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

     vpc_id = "${aws_vpc.default.id}"
     
tags {
    Name = "greninja.bastion.secgroup"
    Environment = "greninja"
    Category = "Kordata"
}
}