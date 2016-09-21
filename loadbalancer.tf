# Create new load blancer for sync_gateway
resource "aws_elb" "sync_gateway" {
    name = "dragonair-sync-gateway-elb"
    internal = "true"
    subnets = ["${aws_subnet.us-west-2a-public.id}"]

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
}

# Create new load blancer for nginx
resource "aws_elb" "nginx" {
    name = "dragonair-nginx-elb"
    internal = "false"
    subnets = ["${aws_subnet.us-west-2a-private.id}"]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    listener {
        instance_port = 5000
        instance_protocol = "http"
        lb_port = 443
        lb_protocol = "https"
        ssl_certificate_id = "arn:aws:iam:905856206022:server-certificate/star_kordata_com1"
    }

    listener {
        instance_port = 4984
        instance_protocol = "http"
        lb_port = "4984"
        lb_protocol = "https"
        ssl_certificate_id = "arn:aws:iam:905856206022:server-certificate/star_kordata_com1"
    }

    listener {
        instance_port = 4985
        instance_protocol = "http"
        lb_port = 4985
        lb_protocol = "https"
        ssl_certificate_id = "arn:aws:iam:905856206022:server-certificate/star_kordata_com1"
    }

    health_check {
        healthy_threshold = 10
        unhealthy_threshold = 2 
        timeout = 5
        target = "http:80/elb-status"
        interval = 30
    }
}

# Create new load blancer for docmosis
resource "aws_elb" "docmosis" {
    name = "dragonair-docmosis-elb"
    internal = "true"
    subnets = ["${aws_subnet.us-west-2a-private.id}"]

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
}