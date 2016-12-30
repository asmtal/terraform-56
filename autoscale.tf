
resource "aws_launch_configuration" "sync_gateway" {
    name = "greninja_sync_gateway_lc"
    image_id = "${var.sync_gateway_ami}"
    instance_type = "t2.small"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    user_data = "${file("user-data/sg_user_data.txt")}"
    key_name = "WaterShuriken"
}

resource "aws_launch_configuration" "docmosis" {
    name = "greninja_docmosis_lc"
    image_id = "${var.docmosis_ami}"
    instance_type = "t2.small"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    user_data = "${file("user-data/docmosis_user_data.txt")}"
    key_name = "WaterShuriken"
}

resource "aws_launch_configuration" "ecs_cluster" {
    name = "greninja_ecs_cluster_ls"
    image_id = "${var.ecs_cluster_ami}"
    instance_type = "t2.small"
    security_groups = ["${aws_security_group.web.id}"]
    associate_public_ip_address = "true"
    user_data = "${file("user-data/ecs_user_data.txt")}"
    iam_instance_profile = "Kordata"
    key_name = "WaterShuriken"
}

resource "aws_autoscaling_group" "ecs_cluster" {
    availability_zones = ["us-west-2a", "us-west-2b"]
    name = "greninja-ecs-cluster-as-group"
    max_size = 2
    min_size = 0
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 1
    target_group_arns = ["${aws_alb_target_group.greninja_4985_public.arn}", 
                        "${aws_alb_target_group.greninja_4984_public.arn}", 
                        "${aws_alb_target_group.greninja_5000_public.arn}",
                        "${aws_alb_target_group.greninja_443_public.arn}",
                        "${aws_alb_target_group.greninja_80_public.arn}"]
    launch_configuration = "${aws_launch_configuration.ecs_cluster.id}"
    vpc_zone_identifier = ["${aws_subnet.us-west-2a-public.id}", 
                        "${aws_subnet.us-west-2b-public.id}"]
    tag {
        key = "Name"
        value = "ecs_cluster.greninja.kordata.as"
        propagate_at_launch = true
    }
    tag {
        key = "Environment"
        value = "greninja"
        propagate_at_launch = true
    }
    tag {
        key = "Category"
        value = "Kordata"
        propagate_at_launch = true
    }
}


resource "aws_autoscaling_group" "sync_gateway" {
    availability_zones = ["us-west-2a", "us-west-2b"]
    name = "greninja-sg-autoscale-group"
    max_size = 2
    min_size = 0
    health_check_grace_period = 300 
    health_check_type = "EC2"
    desired_capacity = 1
    target_group_arns  = ["${aws_alb_target_group.greninja_4984_private.arn}", "${aws_alb_target_group.greninja_4985_private.arn}"]
    launch_configuration = "${aws_launch_configuration.sync_gateway.id}"
    vpc_zone_identifier = [ "${aws_subnet.us-west-2a-private.id}", 
                            "${aws_subnet.us-west-2b-private.id}"]
    tag {
        key = "Name"
        value = "sync-gateway.greninja.kordata.as"
        propagate_at_launch = true
    }
    tag {
        key = "Environment"
        value = "greninja"
        propagate_at_launch = true
    }
    tag {
        key = "Category"
        value = "Kordata"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_group" "docmosis" {
    availability_zones = ["us-west-2a", "us-west-2b"]
    name = "greninja-docmosis-autoscale-group"
    max_size = 2
    min_size = 0
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 1
    target_group_arns = ["${aws_alb_target_group.greninja_docmosis_private.arn}"]
    launch_configuration = "${aws_launch_configuration.docmosis.id}"
    vpc_zone_identifier = [ "${aws_subnet.us-west-2a-private.id}", 
                             "${aws_subnet.us-west-2b-private.id}"]
    tag {
        key = "Name"
        value = "docmosis.greninja.kordata.as"
        propagate_at_launch = true

    }
    tag {
        key = "Environment"
        value = "greninja"
        propagate_at_launch = true
    }
    tag {
        key = "Category"
        value = "Kordata"
        propagate_at_launch = true
    }
}

