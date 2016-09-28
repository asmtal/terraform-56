resource "aws_launch_configuration" "nginx" {
    name = "dragonair_nginx_lc"
    image_id = "${var.nginx_ami}"
    instance_type = "t2.small"
    security_groups = ["${aws_security_group.web.id}"]
    associate_public_ip_address = "true"
    user_data = "${file("user-data/nginx_user_data.txt")}"
    key_name = "dragonrush"
}

resource "aws_launch_configuration" "sync_gateway" {
    name = "dragonair_sync_gateway_lc"
    image_id = "${var.sync_gateway_ami}"
    instance_type = "t2.small"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    user_data = "${file("user-data/sg_user_data.txt")}"
    key_name = "dragonrush"
}

resource "aws_launch_configuration" "docmosis" {
    name = "dragonair_docmosis_lc"
    image_id = "${var.docmosis_ami}"
    instance_type = "t2.small"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    user_data = "${file("user-data/docmosis_user_data.txt")}"
    key_name = "dragonrush"
}

resource "aws_autoscaling_group" "nginx" {
    availability_zones = ["us-west-2a", "us-west-2b"]
    name = "dragonair-nginx-autoscale-group"
    max_size = 2
    min_size = 0
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 0
    load_balancers = ["${aws_elb.nginx.id}"]
    launch_configuration = "${aws_launch_configuration.nginx.id}"
    vpc_zone_identifier = [ "${aws_subnet.us-west-2a-public.id}", 
                            "${aws_subnet.us-west-2b-public.id}"]
    tag {
        key = "Name"
        value = "nginx.dragonair.kordata.as"
    }
    tag {
        key = "Environment"
        value = "Dragonair"
    }
    tag {
        key = "Category"
        value = "Kordata"
    }
}

resource "aws_autoscaling_group" "sync_gateway" {
    availability_zones = ["us-west-2a", "us-west-2b"]
    name = "dragonair-sg-autoscale-group"
    max_size = 2
    min_size = 0
    health_check_grace_period = 300 
    health_check_type = "EC2"
    desired_capacity = 0
    load_balancers = ["${aws_elb.sync_gateway.id}"]
    launch_configuration = "${aws_launch_configuration.sync_gateway.id}"
    vpc_zone_identifier = [ "${aws_subnet.us-west-2a-private.id}", 
                            "${aws_subnet.us-west-2b-private.id}"]
    tag {
        key = "Name"
        value = "sync-gateway.dragonair.kordata.as"
    }
    tag {
        key = "Environment"
        value = "Dragonair"
    }
    tag {
        key = "Category"
        value = "Kordata"
    }
}

resource "aws_autoscaling_group" "docmosis" {
    availability_zones = ["us-west-2a", "us-west-2b"]
    name = "dragonair-docmosis-autoscale-group"
    max_size = 2
    min_size = 0
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 0
    load_balancers = ["${aws_elb.docmosis.id}"]
    launch_configuration = "${aws_launch_configuration.docmosis.id}"
    vpc_zone_identifier = [ "${aws_subnet.us-west-2a-private.id}", 
                             "${aws_subnet.us-west-2b-private.id}"]
    tag {
        key = "Name"
        value = "docmosis.dragonair.kordata.as"
    }
    tag {
        key = "Environment"
        value = "Dragonair"
    }
    tag {
        key = "Category"
        value = "Kordata"
    }
}

