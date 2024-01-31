#This creates a load balancer in front of the public subnet which directs the load to the various ecs clusters in the private subnet
resource "aws_lb" "my_mern_lb" {
  name               = "mern-lb"
  internal           = false
  ip_address_type    = "ipv4" 
  load_balancer_type = "application"
  security_groups    = [aws_security_group.mern_sg.id]
  subnets            = [aws_subnet.lb_subnet_a.id, aws_subnet.lb_subnet_b.id]  
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "mern_tg" {
  name     = "mern-stack-tg"
  port     = 5000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = aws_vpc.practvpc_002.id
}
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_mern_lb.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mern_tg.arn
  }
}
resource "aws_lb_listener_rule" "my_listener_rule" {
  listener_arn = aws_lb_listener.my_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mern_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}