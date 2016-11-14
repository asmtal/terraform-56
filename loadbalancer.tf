# Create new load balancer for sync_gateway
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
        Environment = "Dragonair-Blue"
        Category = "Kordata"
        Name = "sg-dragonair-kordata-elb"
    }
}
# Create new load balancer for docmosis
resource "aws_elb" "docmosis" {
    name = "blue-dragonair-docmosis-elb"
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
        Environment = "Dragonair-Blue"
        Category = "Kordata"
    }
}
#Creates an elb for the cbnodes
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

/*
Application load balancer for the web
Workflow for the alb is as follows:
- aws_alb
- aws_alb_listener
- aws_alb_listener_rule
- aws_alb_target_group
- aws_alb_target_group_attachment
*/

resource "aws_alb" "dragonair_blue" {
    name = "blue-dragonair-alb"
    internal = true
    subnets = ["${aws_subnet.us-west-2a-private.id}", "${aws_subnet.us-west-2b-private.id}"]
    security_groups = ["${aws_security_group.private.id}"]
    enable_deletion_protection = false
    tags {

    }
}
resource "aws_alb_listener" "blue_dragonair_4984" {
    load_balancer_arn = "${aws_alb.dragonair_blue.arn}"
    port = 4984
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::093234080301:server-certificate/blueKordata"
        default_action {
            target_group_arn = "${aws_alb_target_group.blue_dragonair.arn}"
            type = "forward"
        }
}
resource "aws_alb_listener" "blue_dragonair_4985" {
    load_balancer_arn = "${aws_alb.dragonair_blue.arn}"
    port = 4985
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::093234080301:server-certificate/blueKordata"
        default_action {
            target_group_arn = "${aws_alb_target_group.blue_dragonair_4985.arn}"
            type = "forward"
        }
}
resource "aws_alb_listener" "blue_dragonair_8080" {
    load_balancer_arn = "${aws_alb.dragonair_blue.arn}"
    port = 8080
    protocol = "HTTP"
    default_action {
            target_group_arn = "${aws_alb_target_group.blue_dragonair_docmosis.arn}"
            type = "forward"
        }
}
resource "aws_alb_target_group" "blue_dragonair" {
    name = "blue-dragonair-kordata-tg"
    port = 4984
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
    
}
resource "aws_alb_target_group" "blue_dragonair_docmosis" {
    name = "blue-dragonair-doc-kordata-tg"
    port = 8080
    protocol = "HTTP"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTP"
    }
}
resource "aws_alb_target_group" "blue_dragonair_4985" {
    name = "blue-dragonair-4985-tg"
    port = 4985
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
}

################################################
#                                              #
#                 Public ALB                   #
#                                              #
#                                              #
################################################

resource "aws_alb" "dragonair_blue_public" {
    name = "public-blue-dragonair-alb"
    internal = false
    subnets = ["${aws_subnet.us-west-2a-public.id}", "${aws_subnet.us-west-2b-public.id}"]
    security_groups = ["${aws_security_group.web.id}"]
    enable_deletion_protection = false
    tags {

    }
}
resource "aws_alb_listener" "blue_dragonair_4984_public" {
    load_balancer_arn = "${aws_alb.dragonair_blue_public.arn}"
    port = 4984
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::093234080301:server-certificate/blueKordata"
        default_action {
            target_group_arn = "${aws_alb_target_group.blue_dragonair_4984_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_listener" "blue_dragonair_4985_public" {
    load_balancer_arn = "${aws_alb.dragonair_blue_public.arn}"
    port = 4985
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::093234080301:server-certificate/blueKordata"
        default_action {
            target_group_arn = "${aws_alb_target_group.blue_dragonair_4985_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_listener" "blue_dragonair_5500_public" {
    load_balancer_arn = "${aws_alb.dragonair_blue_public.arn}"
    port = 5500
    protocol = "HTTPS"
    certificate_arn = "arn:aws:iam::093234080301:server-certificate/blueKordata"
    default_action {
            target_group_arn = "${aws_alb_target_group.blue_dragonair_80_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_listener" "blue_dragonair_443_public" {
    load_balancer_arn = "${aws_alb.dragonair_blue_public.arn}"
    port = 443
    protocol = "HTTPS"
    certificate_arn = "arn:aws:iam::093234080301:server-certificate/blueKordata"
    default_action {
            target_group_arn = "${aws_alb_target_group.blue_dragonair_443_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_listener" "blue_dragonair_80_public" {
    load_balancer_arn = "${aws_alb.dragonair_blue_public.arn}"
    port = 80
    protocol = "HTTP"
    default_action {
            target_group_arn = "${aws_alb_target_group.blue_dragonair_80_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_target_group" "blue_dragonair_4985_public" {
    name = "nginx-blue-dragonair-4985-tg"
    port = 4985
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
}
resource "aws_alb_target_group" "blue_dragonair_4984_public" {
    name = "nginx-blue-dragonair-4984-tg"
    port = 4984
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
}
resource "aws_alb_target_group" "blue_dragonair_5000_public" {
    name = "nginx-blue-dragonair-5000-tg"
    port = 5000
    protocol = "HTTP"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTP"
    }
}
resource "aws_alb_target_group" "blue_dragonair_443_public" {
    name = "nginx-blue-dragonair-443-tg"
    port = 5000
    protocol = "HTTP"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTP"
    }
}
resource "aws_alb_target_group" "blue_dragonair_80_public" {
    name = "nginx-blue-dragonair-80-tg"
    port = 8080
    protocol = "HTTP"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTP"
    }
}