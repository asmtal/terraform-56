/*
  Database Servers
*/
resource "aws_security_group" "private" {
    description = "Allow incoming web/database connections."
    name = "greninja_private_secgroup"

    ingress { # http
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress { # http
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 4369
        to_port = 4369
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 9998
        to_port = 9999
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 3001
        to_port = 3001
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 4984
        to_port = 4985
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 18091
        to_port = 18095
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 9100
        to_port = 9105
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 21100
        to_port = 21299
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 8091
        to_port = 8095
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 8091
        to_port = 8095
        protocol = "tcp"
        cidr_blocks = ["10.1.0.0/16"]
    }
    ingress {
        from_port = 18091
        to_port = 18095
        protocol = "tcp"
        cidr_blocks = ["10.1.0.0/16"]
    }
    ingress {
        from_port = 9500
        to_port = 9500
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 11207
        to_port = 11215
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 11207
        to_port = 11215
        protocol = "tcp"
        cidr_blocks = ["10.1.0.0/16"]
    }     
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 18901
        to_port = 18905
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 4369
        to_port = 4369
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 9998
        to_port = 9999
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 4984
        to_port = 4985
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 123
        to_port = 123
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 9100
        to_port = 9105
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 21100
        to_port = 21299
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 8091
        to_port = 8095
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 8091
        to_port = 8095
        protocol = "tcp"
        cidr_blocks = ["10.1.0.0/16"]
    }
    egress {
        from_port = 18091
        to_port = 18095
        protocol = "tcp"
        cidr_blocks = ["10.1.0.0/16"]
    }
    egress {
        from_port = 9500
        to_port = 9500
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 11207
        to_port = 11215
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 11207
        to_port = 11215
        protocol = "tcp"
        cidr_blocks = ["10.1.0.0/16"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "greninja.private.secgroup"
        Category = "Kordata"
        Environment = "Greninja"
    }
}
