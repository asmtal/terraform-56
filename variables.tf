variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-2"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/22"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}

variable "nginx_ami" { 
    description = "Generic nginx ami"
    default = "ami-9627ecf6" 
}

variable "sync_gateway_ami" {
    description = "Generic sync_gateway ami"
    default = "ami-ef11db8f"
}

variable "docmosis_ami" {
    description = "Generic docmosis ami"
    default = "ami-7fb1711f"
}

