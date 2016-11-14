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
    default = "10.0.16.0/22"
}

variable "public_subnet_cidr_a" {
    description = "CIDR for the Public Subnet"
    default = "10.0.16.0/24"
}

variable "public_subnet_cidr_b" {
    description = "CIDR for the public subnet b"
    default = "10.0.17.0/24"
}

variable "private_subnet_cidr_a" {
    description = "CIDR for the Private Subnet"
    default = "10.0.18.0/24"
}

variable "private_subnet_cidr_b" {
    description = "CIDR for private subnet b"
    default = "10.0.19.0/24"
}

variable "nginx_ami" { 
    description = "Generic nginx ami"
    default = "ami-9627ecf6" 
}

variable "sync_gateway_ami" {
    description = "Generic sync_gateway ami"
    default = "ami-e8963188"
}

variable "docmosis_ami" {
    description = "Generic docmosis ami"
    default = "ami-7fb1711f"
}

variable "bastion_ami" {
    description = "Generic bastion host"
    default = "ami-03877563"
}

variable "ecs_cluster_ami" {
    description = "ECS Ami"
    default = "ami-56ed4936"
}

variable "admin_user" {
    default = "admin"
}

variable "admin_password" {
    default = "!4dm1n!"
}

variable "cluster_ram_quota" {
    default = "9350"
}

variable "bucket_ram_quota" {
    default = "9000"
}

variable "couchbase_default_bucket_name" {
    default = "sandbox_sync_gateway"
}

variable "couchbase_default_replicas" {
    default = "1"
}
