resource "aws_security_group" "mern_sg" {
  name        = "mern_stack_demo_sg"
  vpc_id      = aws_vpc.practvpc_002.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
  }
}
