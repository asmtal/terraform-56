/*
  Web Servers
*/
resource "aws_security_group" "web" {
    name = "greninja_public_secgroup"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 4985
        to_port = 4985
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
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 9998
        to_port = 9999
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 4984
        to_port = 4984
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 3001
        to_port = 3001
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 9418
        to_port = 9418
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8888
        to_port = 8888
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 9100
        to_port = 9105
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 18091
        to_port = 18092
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
        from_port = 21100
        to_port = 21299
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port = 5555
        to_port = 5555
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
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
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 5000
        to_port = 5000
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
        to_port = 4984
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 4985
        to_port = 4985
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 3001
        to_port = 3001
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
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
        from_port = 9418
        to_port = 9418
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
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
        from_port = 9500
        to_port = 9500
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 587
        to_port = 587
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 11207
        to_port = 11215
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "greninja.public.secgroup"
        Category = "Kordata"
        Environment = "Greninja"
    }
}
