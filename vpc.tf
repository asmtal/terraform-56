/*
  VPC configuration for test environment
*/


resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "DRAGONAIR-kordata"
        Environment = "Dragonair"
        Category = "Kordata"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

// create the variable for eip, defaults to nothing
variable "eip" { default = "" }

resource "aws_eip" "nat" {
    count="${replace(replace(var.eip,"/.+/","0"),"/^$/","1")}"
}

resource "aws_nat_gateway" "gw" {
    allocation_id = "${coalesce(var.eip,aws_eip.nat.id)}"
    subnet_id = "${aws_subnet.us-west-2a-public.id}"
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
        Name = "DRAGONAIR-public-2a"
        Environment = "Dragonair"
        Category = "Kordata" 
    }
}

resource "aws_route_table" "us-west-2a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "DRAGONAIR-Public-2a"
        Environment = "Dragonair"
        Category = "Kordata"
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
        Name = "DRAGONAIR-public-2b"
        Environment = "Dragonair"
        Category = "Kordata" 
    }
}

resource "aws_route_table" "us-west-2b-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "DRAGONAIR-Public-2b"
        Environment = "Dragonair"
        Category = "Kordata"
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
        Name = "DRAGONAIR-private-2a"
        Environment = "Dragonair"
        Category = "Kordata"
    }
}

resource "aws_route_table" "us-west-2a-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags {
        Name = "DRAGONAIR-private-2a"
        Environment = "Dragonair"
        Category = "Kordata"
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
        Name = "DRAGONAIR-private-2b"
        Environment = "Dragonair"
        Category = "Kordata"
    }
}

resource "aws_route_table" "us-west-2b-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags {
        Name = "DRAGONAIR-private-2b"
        Environment = "Dragonair"
        Category = "Kordata"
    }
}

resource "aws_route_table_association" "us-west-2b-private" {
    subnet_id = "${aws_subnet.us-west-2b-private.id}"
    route_table_id = "${aws_route_table.us-west-2b-private.id}"
}