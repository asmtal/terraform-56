# Create new load blancer for sync_gateway
resource "aws_elb" "sync_gateway" {
    name = "dragonair-sync-gateway-elb"
    internal = "true"
    subnets = ["${aws_subnet.us-west-2a-private.id}", "${aws_subnet.us-west-2b-private.id}"]
    security_groups = ["${aws_security_group.private.id}"]

    listener {
        instance_port = 4984
        instance_protocol = "http"
        lb_port = 4984
        lb_protocol = "http"
    }

    listener {
        instance_port = 4985
        instance_protocol = "http"
        lb_port = 4985
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 4
        unhealthy_threshold = 2
        timeout = 10
        target = "http:4984/"
        interval = 20
    }
    tags {
        Environment = "Dragonair"
        Category = "Kordata"
        Name = "sg-dragonair-kordata-elb"
    }
}

# Create new load blancer for nginx
resource "aws_elb" "nginx" {
    name = "dragonair-nginx-elb"
    internal = "false"
    subnets = ["${aws_subnet.us-west-2a-public.id}", "${aws_subnet.us-west-2b-public.id}"]
    security_groups = ["${aws_security_group.web.id}"]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 8080
        lb_protocol = "http"
    }

    listener {
        instance_port = 5000
        instance_protocol = "http"
        lb_port = 443
        lb_protocol = "https"
        ssl_certificate_id = "arn:aws:iam::905856206022:server-certificate/star_kordata_com1"
    }

    listener {
        instance_port = 4984
        instance_protocol = "http"
        lb_port = 4984
        lb_protocol = "https"
        ssl_certificate_id = "arn:aws:iam::905856206022:server-certificate/star_kordata_com1"
    }

    listener {
        instance_port = 4985
        instance_protocol = "http"
        lb_port = 4985
        lb_protocol = "https"
        ssl_certificate_id = "arn:aws:iam::905856206022:server-certificate/star_kordata_com1"
    }

    health_check {
        healthy_threshold = 10
        unhealthy_threshold = 2 
        timeout = 5
        target = "http:80/elb-status"
        interval = 30
    }
    tags {
        Name = "nginx-dragonair-kordata-elb"
        Environment = "Dragonair"
        Category = "Kordata" 
    }
}

# Create new load blancer for docmosis
resource "aws_elb" "docmosis" {
    name = "dragonair-docmosis-elb"
    internal = "true"
    subnets = ["${aws_subnet.us-west-2a-private.id}", "${aws_subnet.us-west-2a-private.id}"]
    security_groups = ["${aws_security_group.private.id}"]

    listener {
        instance_port = 8080
        instance_protocol = "http"
        lb_port = 8080
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 10
        unhealthy_threshold = 2
        timeout = 5
        target = "http:8080/tornado.html"
        interval = 30
    }
    tags {
        Name = "docmosis-dragonair-kordata-elb"
        Environment = "Dragonair"
        Category = "Kordata"
    }
}

resource "aws_elb" "cbnodes" {
    name = "dragonair-cbnodes-elb"
    internal = "true"
    subnets = ["${aws_subnet.us-west-2a-private.id}", "${aws_subnet.us-west-2a-private.id}"]
    security_groups = ["${aws_security_group.private.id}"]

    listener {
        instance_port = 8091
        instance_protocol = "http"
        lb_port = 8091
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 10
        unhealthy_threshold = 2
        timeout = 5
        target = "http:8091/index.html"
        interval = 30
    }
    tags {
        Name = "cbnodes-dragonair-kordata-elb"
        Environment = "Dragonair"
        Category = "Kordata"
    }
}