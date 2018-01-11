
/*
Application load balancer for the web
Workflow for the alb is as follows:
- aws_alb
- aws_alb_listener
- aws_alb_listener_rule
- aws_alb_target_group
- aws_alb_target_group_attachment
*/

resource "aws_alb" "environment_private" {
    name = "private-environment-alb"
    internal = true
    subnets = ["${aws_subnet.us-west-2a-private.id}", "${aws_subnet.us-west-2b-private.id}"]
    security_groups = ["${aws_security_group.private.id}"]
    enable_deletion_protection = false
    tags {

    }
}
resource "aws_alb_listener" "environment_4984" {
    load_balancer_arn = "${aws_alb.environment_private.arn}"
    port = 4984
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::XXXXXXXXXXXX:server-certificate/star_name_com1"
        default_action {
            target_group_arn = "${aws_alb_target_group.environment_4984_private.arn}"
            type = "forward"
        }
}
resource "aws_alb_listener" "environment_4985" {
    load_balancer_arn = "${aws_alb.environment_private.arn}"
    port = 4985
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::XXXXXXXXXXXX:server-certificate/star_name_com1"
        default_action {
            target_group_arn = "${aws_alb_target_group.environment_4985_private.arn}"
            type = "forward"
        }
}
resource "aws_alb_listener" "environment_8443" {
    load_balancer_arn = "${aws_alb.environment_private.arn}"
    port = 8443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::XXXXXXXXXXXX:server-certificate/star_name_com1"
    default_action {
            target_group_arn = "${aws_alb_target_group.environment_docmosis_private.arn}"
            type = "forward"
        }
}
resource "aws_alb_target_group" "environment_4984_private" {
    name = "sg4984-environment-name-tg"
    port = 4984
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
    
}
resource "aws_alb_target_group" "environment_docmosis_private" {
    name = "docmosis8443-environment-name-tg"
    port = 8443
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
        path = "/tornado.html"
    }
}
resource "aws_alb_target_group" "environment_4985_private" {
    name = "sg4985-environment-4985-tg"
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

resource "aws_alb" "environment_public" {
    name = "public-environment-alb"
    internal = false
    subnets = ["${aws_subnet.us-west-2a-public.id}", "${aws_subnet.us-west-2b-public.id}"]
    security_groups = ["${aws_security_group.web.id}"]
    enable_deletion_protection = false
    tags {

    }
}
resource "aws_alb_listener" "environment_4984_public" {
    load_balancer_arn = "${aws_alb.environment_public.arn}"
    port = 4984
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = "arn:aws:iam::XXXXXXXXXXXX:server-certificate/star_name_com1"
        default_action {
            target_group_arn = "${aws_alb_target_group.environment_4984_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_listener" "environment_443_public" {
    load_balancer_arn = "${aws_alb.environment_public.arn}"
    port = 443
    protocol = "HTTPS"
    certificate_arn = "arn:aws:iam::XXXXXXXXXXXX:server-certificate/star_name_com1"
    default_action {
            target_group_arn = "${aws_alb_target_group.environment_443_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_listener" "environment_80_public" {
    load_balancer_arn = "${aws_alb.environment_public.arn}"
    port = 80
    protocol = "HTTP"
    default_action {
            target_group_arn = "${aws_alb_target_group.environment_80_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_listener" "environment_4985_public" {
    load_balancer_arn = "${aws_alb.environment_public.arn}"
    port = 4985
    protocol = "HTTPS"
    certificate_arn = "arn:aws:iam::XXXXXXXXXXXX:server-certificate/star_name_com1"
    default_action {
            target_group_arn = "${aws_alb_target_group.environment_4985_public.arn}" #Change me
            type = "forward"
        }
}
resource "aws_alb_target_group" "environment_4985_public" {
    name = "nginx4985-environment-name-tg"
    port = 4985
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
}
resource "aws_alb_target_group" "environment_4984_public" {
    name = "nginx4984-environment-name-tg"
    port = 4984
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
    }
}
resource "aws_alb_target_group" "environment_443_public" {
    name = "nginx443-environment-name-tg"
    port = 443
    protocol = "HTTPS"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTPS"
        path = "/Account/Login"
    }
}
resource "aws_alb_target_group" "environment_80_public" {
    name = "nginx80-environment-name-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = "${aws_vpc.default.id}"
    health_check {
        interval = 10
        port = "traffic-port"
        protocol = "HTTP"
        path = "/health-check"
    }
}