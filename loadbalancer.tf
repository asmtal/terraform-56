
/*
Application load balancer for the web
Workflow for the alb is as follows:
- aws_alb
- aws_alb_listener
- aws_alb_listener_rule
- aws_alb_target_group
- aws_alb_target_group_attachment
*/

resource "aws_alb" "greninja_private" {
    name = "private-greninja-alb"
    internal = true
    subnets = ["${aws_subnet.us-west-2a-private.id}", "${aws_subnet.us-west-2b-private.id}"]
    security_groups = ["${aws_security_group.private.id}"]
    enable_deletion_protection = false
    tags {

    }
}
resource "aws_alb_listener" "Greninja_4984" {
    load_balancer_arn = "${aws_alb.greninja_private.arn}"
    port = 4984
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::905856206022:server-certificate/star_kordata_com1"
        default_action {
            target_group_arn = "${aws_alb_target_group.greninja_4984_private.arn}"
            type = "forward"
        }
}
resource "aws_alb_listener" "Greninja_4985" {
    load_balancer_arn = "${aws_alb.greninja_private.arn}"
    port = 4985
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::905856206022:server-certificate/star_kordata_com1"
        default_action {
            target_group_arn = "${aws_alb_target_group.greninja_4985_private.arn}"
            type = "forward"
        }
}
resource "aws_alb_listener" "Greninja_8443" {
    load_balancer_arn = "${aws_alb.greninja_private.arn}"
    port = 8443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam:905856206022:server-certificate/star_kordata_com1"
    default_action {
            target_group_arn = "${aws_alb_target_group.greninja_docmosis_private.arn}"
            type = "forward"
        }
}
resource "aws_alb_target_group" "greninja_4984_private" {
    name = "sg4984-greninja-kordata-tg"
    port = 4984
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
    
}
resource "aws_alb_target_group" "greninja_docmosis_private" {
    name = "docmosis8443-greninja-kordata-tg"
    port = 8443
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
}
resource "aws_alb_target_group" "greninja_4985_private" {
    name = "sg4985-greninja-4985-tg"
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

resource "aws_alb" "greninja_public" {
    name = "public-greninja-alb"
    internal = false
    subnets = ["${aws_subnet.us-west-2a-public.id}", "${aws_subnet.us-west-2b-public.id}"]
    security_groups = ["${aws_security_group.web.id}"]
    enable_deletion_protection = false
    tags {

    }
}
resource "aws_alb_listener" "greninja_4984_public" {
    load_balancer_arn = "${aws_alb.greninja_public.arn}"
    port = 4984
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::905856206022:server-certificate/star_kordata_com1"
        default_action {
            target_group_arn = "${aws_alb_target_group.greninja_4984_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_listener" "greninja_443_public" {
    load_balancer_arn = "${aws_alb.greninja_public.arn}"
    port = 443
    protocol = "HTTPS"
    certificate_arn = "arn:aws:iam::905856206022:server-certificate/star_kordata_com1"
    default_action {
            target_group_arn = "${aws_alb_target_group.greninja_443_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_listener" "greninja_80_public" {
    load_balancer_arn = "${aws_alb.greninja_public.arn}"
    port = 80
    protocol = "HTTP"
    default_action {
            target_group_arn = "${aws_alb_target_group.greninja_80_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_target_group" "greninja_4985_public" {
    name = "nginx4985-greninja-kordata-tg"
    port = 4985
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
}
resource "aws_alb_target_group" "greninja_4984_public" {
    name = "nginx4984-greninja-kordata-tg"
    port = 4984
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
}
resource "aws_alb_target_group" "greninja_443_public" {
    name = "nginx443-greninja-kordata-tg"
    port = 443
    protocol = "HTTP"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
}
resource "aws_alb_target_group" "greninja_80_public" {
    name = "nginx80-greninja-kordata-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTP"
    }
}