# Create new load blancer for sync_gateway
resource "aws_elb" "sync_gateway" {
    name = "shedinja-sync-gateway-elb"
    availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
    internal = "true"
    instances = ["${aws_instances.sync_gateway.id}"]
    subnets = "${var.private_subnet_cidr}"

    listener {
        instance_port = 
        instance_protocol = ""
        lb_port = 
        lb_protocol = ""
    }

    listener {
        instance_port = 
        instance_protocol = ""
        lb_port = 
        lb_protocol = ""
        ssl_certificate_id = "arn"
    }

    health_check {
        healthy_threshold =
        unhealthy_threshold = 
        timeout =
        target = 
        interval = 
    }
}

# Create new load blancer for nginx
resource "aws_elb" "nginx" {
    name = "shedinja-nginx-elb"
    availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
    internal = "true"
    instances = ["${aws_instances.nginx.id}"]
    subnets = "${var.public_subnet_cidr}"

    listener {
        instance_port = 
        instance_protocol = ""
        lb_port = 
        lb_protocol = ""
    }

    listener {
        instance_port = 
        instance_protocol = ""
        lb_port = 
        lb_protocol = ""
        ssl_certificate_id = "arn"
    }

    health_check {
        healthy_threshold =
        unhealthy_threshold = 
        timeout =
        target = 
        interval = 
    }
}

# Create new load blancer for docmosis
resource "aws_elb" "docmosis" {
    name = "shedinja-docmosis-elb"
    availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
    internal = "true"
    instances = ["${aws_instances.docmosis.id}"]
    subnets = "${var.private_subnet_cidr}"

    listener {
        instance_port = 
        instance_protocol = ""
        lb_port = 
        lb_protocol = ""
    }

    listener {
        instance_port = 
        instance_protocol = ""
        lb_port = 
        lb_protocol = ""
        ssl_certificate_id = "arn"
    }

    health_check {
        healthy_threshold =
        unhealthy_threshold = 
        timeout =
        target = 
        interval = 
    }
}