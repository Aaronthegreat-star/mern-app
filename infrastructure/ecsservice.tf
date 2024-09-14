resource "aws_ecs_task_definition" "my_ecs_task" {
  family                   = "my-ecs-task-def"
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "3072" 
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      "name"                   = "mern-backend-container"
      "image"                  = "aaronhod/mn:1"
      "cpu"                    = 1024
      "memory"                 = 2048
      "memoryReservation"      = 1024
      "essential"              = true
      "environment"            = [
        { "name" = "PORT", "value" = "5000" },
        { "name" = "MONGO_DB", "value" = "mongodb+srv://Courage:Couragesister1@atlascluster.cntbtot.mongodb.net/?retryWrites=true&w=majority" },
      ]
      "portMappings"          = [
        {
          "containerPort" = 5000
          "hostPort"      = 5000
          "protocol"      = "tcp"
        }
      ]
    }
  ])
}


resource "aws_ecs_service" "mern_service" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.mern_ecs_cluster.arn
  task_definition = aws_ecs_task_definition.my_ecs_task.arn
  desired_count   = 1
  launch_type = "FARGATE"

  network_configuration {
  subnets = [aws_subnet.lb_subnet_a.id]
  security_groups = [aws_security_group.mern_sg.id]
  assign_public_ip = true
  }

  load_balancer {
    container_name = "mern-backend-container"
    container_port = 5000
    target_group_arn = aws_lb_target_group.mern_tg.arn

  }

}