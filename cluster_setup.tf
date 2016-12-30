resource "aws_instance" "couchbase_cluster_node1" {
    ami = "ami-c8f62ea8"
    instance_type = "r3.large"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    subnet_id = "${aws_subnet.us-west-2a-private.id}"
    key_name = "WaterShuriken"
    user_data = "${file("user-data/greninja_couchbase_user_data.txt")}"
    tags {
        Name = "cbnode.greninja.kordata"
        Environment = "Greninja"
        Category = "Kordata"
    }
}
resource "aws_instance" "couchbase_cluster_node2" {
    ami = "ami-c8f62ea8"
    instance_type = "r3.large"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    subnet_id = "${aws_subnet.us-west-2a-private.id}"
    key_name = "WaterShuriken"
    tags {
        Name = "cbnode.greninja.kordata"
        Environment = "Greninja"
        Category = "Kordata"
    }
}
resource "aws_instance" "couchbase_cluster_node3" {
    ami = "ami-c8f62ea8"
    instance_type = "r3.large"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    subnet_id = "${aws_subnet.us-west-2a-private.id}"
    key_name = "WaterShuriken"
    tags {
        Name = "cbnode.greninja.kordata"
        Environment = "Greninja"
        Category = "Kordata"
    }
}
resource "aws_instance" "couchbase_cluster_node4" {
    ami = "ami-c8f62ea8"
    instance_type = "r3.large"
    security_groups = ["${aws_security_group.private.id}"]
    associate_public_ip_address = "false"
    subnet_id = "${aws_subnet.us-west-2a-private.id}"
    key_name = "WaterShuriken"
    tags {
        Name = "cbnode.greninja.kordata"
        Environment = "Greninja"
        Category = "Kordata"
    }
}

resource "null_resource" "couchbase_cluster_formation" {
    triggers {
        couchbase_node1_private_ip = "${aws_instance.couchbase_cluster_node1.private_ip}"
        couchbase_node2_private_ip = "${aws_instance.couchbase_cluster_node2.private_ip}"
        couchbase_node3_private_ip = "${aws_instance.couchbase_cluster_node3.private_ip}"
        couchbase_node4_private_ip = "${aws_instance.couchbase_cluster_node4.private_ip}"
        bastion_host_public_ip = "${aws_instance.bastion.public_ip}"
    }

provisioner "remote-exec" {
    connection {
        type = "ssh"
        user = "ubuntu"
        bastion_host = "${aws_instance.bastion.public_ip}"
        bastion_port = 1775
        bastion_user = "ubuntu"
        bastion_private_key = "${file("aws_priv_key_file/WaterShuriken.pem")}"
        host = "${aws_instance.couchbase_cluster_node1.private_ip}"
        private_key = "${file("aws_priv_key_file/WaterShuriken.pem")}"
        }
inline = [
    "sleep 10",
    "/opt/couchbase/bin/couchbase-cli cluster-init -c ${aws_instance.couchbase_cluster_node1.private_ip}:8091 --cluster-init-username=${var.admin_user} --cluster-init-password=${var.admin_password} --cluster-init-port=8091 --cluster-init-ramsize=${var.cluster_ram_quota}",
    "sleep 5",
    "/opt/couchbase/bin/couchbase-cli setting-cluster -c ${aws_instance.couchbase_cluster_node1.private_ip}:8091 -u ${var.admin_user} -p ${var.admin_password} --cluster-name Pokemon_Env --cluster-ramsize=${var.cluster_ram_quota}",
    "sleep 10",
    "/opt/couchbase/bin/couchbase-cli cluster-edit -c ${aws_instance.couchbase_cluster_node1.private_ip}:8091 -u ${var.admin_user} -p ${var.admin_password} --services=index",
    "/opt/couchbase/bin/couchbase-cli bucket-create -c ${aws_instance.couchbase_cluster_node1.private_ip}:8091 -u ${var.admin_user} -p ${var.admin_password} --bucket=${var.couchbase_default_bucket_name} --bucket-type=couchbase --bucket-port=11211 --bucket-ramsize=${var.bucket_ram_quota} --bucket-replica=${var.couchbase_default_replicas}",
    "/opt/couchbase/bin/couchbase-cli server-add -c ${aws_instance.couchbase_cluster_node1.private_ip}:8091 -u ${var.admin_user} -p ${var.admin_password} --server-add=${aws_instance.couchbase_cluster_node2.private_ip}:8091 --server-add-username=${var.admin_user} --server-add-password=${var.admin_password} --services=data,query",
    "/opt/couchbase/bin/couchbase-cli server-add -c ${aws_instance.couchbase_cluster_node1.private_ip}:8091 -u ${var.admin_user} -p ${var.admin_password} --server-add=${aws_instance.couchbase_cluster_node3.private_ip}:8091 --server-add-username=${var.admin_user} --server-add-password=${var.admin_password} --services=data,query",
    "/opt/couchbase/bin/couchbase-cli server-add -c ${aws_instance.couchbase_cluster_node1.private_ip}:8091 -u ${var.admin_user} -p ${var.admin_password} --server-add=${aws_instance.couchbase_cluster_node4.private_ip}:8091 --server-add-username=${var.admin_user} --server-add-password=${var.admin_password} --services=data,query",
    "/opt/couchbase/bin/couchbase-cli rebalance -c ${aws_instance.couchbase_cluster_node1.private_ip}:8091 -u ${var.admin_user} -p ${var.admin_password}"
    
]   
    }
}
