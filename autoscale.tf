
resource "aws_launch_configuration" "sync_gateway" {
    name = "sync_gateway_lc"
    image_id = "${var.sync_gateway_ami}"
    instance_type = "c4.xlarge"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    placement_tenancy = "dedicated"
    user_data = "${file("user-data/sg_user_data.txt")}"
    key_name = "PemKeyName"
}

resource "aws_launch_configuration" "docmosis" {
    name = "docmosis_lc"
    image_id = "${var.docmosis_ami}"
    instance_type = "m4.large"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    placement_tenancy = "dedicated"
    user_data = "${file("user-data/docmosis_user_data.txt")}"
    key_name = "PemKeyName"
}

resource "aws_launch_configuration" "ecs_cluster" {
    name = "ecs_cluster_ls"
    image_id = "${var.ecs_cluster_ami}"
    instance_type = "c4.xlarge"
    security_groups = ["${aws_security_group.web.id}"]
    associate_public_ip_address = "true"
    user_data = "${file("user-data/ecs_user_data.txt")}"
    placement_tenancy = "dedicated"
    iam_instance_profile = "ProfileName"
    key_name = "PemKeyName"
}

resource "aws_autoscaling_group" "ecs_cluster" {
    availability_zones = ["us-west-2a", "us-west-2b"]
    name = "ecs-cluster-as-group"
    max_size = 2
    min_size = 0
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 2
    target_group_arns = ["${aws_alb_target_group._4985_public.arn}", 
                        "${aws_alb_target_group._4984_public.arn}", 
                        "${aws_alb_target_group._443_public.arn}",
                        "${aws_alb_target_group._80_public.arn}"]
    launch_configuration = "${aws_launch_configuration.ecs_cluster.id}"
    vpc_zone_identifier = ["${aws_subnet.us-west-2a-public.id}", 
                        "${aws_subnet.us-west-2b-public.id}"]
    tag {
        key = "Name"
        value = "ecs_cluster.as"
        propagate_at_launch = true
    }
    tag {
        key = "Environment"
        value = "SomeEnvName"
        propagate_at_launch = true
    }
    tag {
        key = "Category"
        value = "SomeCategoryName"
        propagate_at_launch = true
    }
}


resource "aws_autoscaling_group" "sync_gateway" {
    availability_zones = ["us-west-2a", "us-west-2b"]
    name = "sg-autoscale-group"
    max_size = 2
    min_size = 0
    health_check_grace_period = 300 
    health_check_type = "EC2"
    desired_capacity = 1
    target_group_arns  = ["${aws_alb_target_group.4984_private.arn}", "${aws_alb_target_group.4985_private.arn}"]
    launch_configuration = "${aws_launch_configuration.sync_gateway.id}"
    vpc_zone_identifier = [ "${aws_subnet.us-west-2a-private.id}", 
                            "${aws_subnet.us-west-2b-private.id}"]
    tag {
        key = "Name"
        value = "sync-gateway.as"
        propagate_at_launch = true
    }
    tag {
        key = "Environment"
        value = "SomeEnvName"
        propagate_at_launch = true
    }
    tag {
        key = "Category"
        value = "SomeCategoryName"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_group" "docmosis" {
    availability_zones = ["us-west-2a", "us-west-2b"]
    name = "docmosis-autoscale-group"
    max_size = 2
    min_size = 0
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 1
    target_group_arns = ["${aws_alb_target_group.docmosis_private.arn}"]
    launch_configuration = "${aws_launch_configuration.docmosis.id}"
    vpc_zone_identifier = [ "${aws_subnet.us-west-2a-private.id}", 
                             "${aws_subnet.us-west-2b-private.id}"]
    tag {
        key = "Name"
        value = "docmosis.as"
        propagate_at_launch = true

    }
    tag {
        key = "Environment"
        value = "SomeEnvName"
        propagate_at_launch = true
    }
    tag {
        key = "Category"
        value = "SomeCategoryName"
        propagate_at_launch = true
    }
}

