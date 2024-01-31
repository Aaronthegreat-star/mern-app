resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name = "ECSTaskDefExecutionRolePolicy"
  role = aws_iam_role.ecs_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
            Effect = "Allow",
            Action = [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            Resource = "*"
        }
    ]
})
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ECSTaskDefExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
        {
            Sid = "",
            Effect = "Allow",
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
            },
            Action = "sts:AssumeRole"
        }
    ]
})
}