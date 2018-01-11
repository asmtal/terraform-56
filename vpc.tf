/*
  VPC configuration for test environment
*/


resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    instance_tenancy = "dedicated"
    tags {
        Name = "environment-name"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
    tags {
        Name = "environment-igw"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}

// create the variable for eip, defaults to nothing
variable "eip1" { default = "" }
variable "eip2" { default = "" }

resource "aws_eip" "nat1" {
    count="${replace(replace(var.eip1,"/.+/","0"),"/^$/","1")}"
}
resource "aws_eip" "nat2" {
    count="${replace(replace(var.eip2,"/.+/","0"),"/^$/","1")}"
}

resource "aws_nat_gateway" "gw" {
    allocation_id = "${coalesce(var.eip1,aws_eip.nat1.id)}"
    subnet_id = "${aws_subnet.us-west-2a-public.id}"
    depends_on = ["aws_internet_gateway.default"]
    
}
resource "aws_nat_gateway" "gw2" {
    allocation_id = "${coalesce(var.eip2,aws_eip.nat2.id)}"
    subnet_id = "${aws_subnet.us-west-2b-public.id}"
    depends_on = ["aws_internet_gateway.default"]
    
}

/*
  Public Subnet
*/
resource "aws_subnet" "us-west-2a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr_a}"
    availability_zone = "us-west-2a"

    tags {
        Name = "environment-public-2a"
        Environment = "environment"
        Category = "SomeCategoryName" 
    }
}

resource "aws_route_table" "us-west-2a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "environment-Public-2a"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}

resource "aws_route_table_association" "us-west-2a-public" {
    subnet_id = "${aws_subnet.us-west-2a-public.id}"
    route_table_id = "${aws_route_table.us-west-2a-public.id}"
}
resource "aws_subnet" "us-west-2b-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr_b}"
    availability_zone = "us-west-2b"

    tags {
        Name = "environment-public-2b"
        Environment = "environment"
        Category = "SomeCategoryName" 
    }
}

resource "aws_route_table" "us-west-2b-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "environment-Public-2b"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}

resource "aws_route_table_association" "us-west-2b-public" {
    subnet_id = "${aws_subnet.us-west-2b-public.id}"
    route_table_id = "${aws_route_table.us-west-2b-public.id}"
}

/*
  Private Subnet
*/
resource "aws_subnet" "us-west-2a-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr_a}"
    availability_zone = "us-west-2a"

    tags {
        Name = "environment-private-2a"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}

resource "aws_route_table" "us-west-2a-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags {
        Name = "environment-private-2a"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}

resource "aws_route_table_association" "us-west-2a-private" {
    subnet_id = "${aws_subnet.us-west-2a-private.id}"
    route_table_id = "${aws_route_table.us-west-2a-private.id}"
}

resource "aws_subnet" "us-west-2b-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr_b}"
    availability_zone = "us-west-2b"

    tags {
        Name = "environment-private-2b"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}

resource "aws_route_table" "us-west-2b-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gw2.id}"
    }

    tags {
        Name = "environment-private-2b"
        Environment = "environment"
        Category = "SomeCategoryName"
    }
}

resource "aws_route_table_association" "us-west-2b-private" {
    subnet_id = "${aws_subnet.us-west-2b-private.id}"
    route_table_id = "${aws_route_table.us-west-2b-private.id}"
}

resource "aws_vpc_peering_connection" "environment-cb" {
    peer_owner_id = "${var.peer_owner_id}"
    peer_vpc_id = "${var.peer_vpc_id}"
    vpc_id = "${aws_vpc.default.id}"
    auto_accept = true

    tags {
        Name = "environment"
    }
}