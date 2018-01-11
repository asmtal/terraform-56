resource "aws_ecr_repository" "name" {
    name = "environment" 
}

resource "aws_ecr_repository_policy" "name_policy" {
    repository = "${aws_ecr_repository.name.name}"
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

resource "aws_ecs_cluster" "web-name-ecs" {
    name = "web-environment-name-ecs"
}
resource "aws_ecs_task_definition" "name-web" {
    family = "name-web"
    container_definitions = "${file("user-data/name-web.json")}"
    task_role_arn = "arn:aws:iam::XXXXXXXXXXXX:role/name-ECS-Task"
}
resource "aws_ecs_service" "name_web" {
    name = "name-web"
    cluster = "${aws_ecs_cluster.web-name-ecs.id}"
    task_definition = "${aws_ecs_task_definition.name-web.arn}"
    desired_count = 1
}

