resource "aws_ecr_repository" "kordata" {
    name = "kordata" 
}

resource "aws_ecr_repository_policy" "kordata_policy" {
    repository = "${aws_ecr_repository.kordata.name}"
    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}

resource "aws_ecs_cluster" "web-kordata-ecs" {
    name = "web-blue-dragonair-kordata-ecs"
}
resource "aws_ecs_task_definition" "kordata-web" {
    family = "kordata-web"
    container_definitions = "${file("user-data/kordata-web.json")}"
}
resource "aws_ecs_service" "kordata_web" {
    name = "kordata-web"
    cluster = "${aws_ecs_cluster.web-kordata-ecs.id}"
    task_definition = "${aws_ecs_task_definition.kordata-web.arn}"
    desired_count = 1
}
