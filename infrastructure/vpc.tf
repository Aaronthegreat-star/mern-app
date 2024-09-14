//This specifies the vpc environment
resource "aws_vpc" "practvpc_002" {
    cidr_block = "10.2.0.0/16"
}
//This deploys the public subnet
resource "aws_subnet" "lb_subnet_a" {
  vpc_id     = "${aws_vpc.practvpc_002.id}"
  cidr_block = "10.2.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "lb_subnet_b" {
  vpc_id     = "${aws_vpc.practvpc_002.id}"
  cidr_block = "10.2.2.0/24"
  availability_zone = "us-east-1b"
}


//This creates the internet gateway for the VPC
resource "aws_internet_gateway" "my_ig" {
  vpc_id = "${aws_vpc.practvpc_002.id}"
}

resource "aws_route_table" "lb_route" {
  vpc_id = aws_vpc.practvpc_002.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }
}

resource "aws_route_table_association" "public_route_a" {
  subnet_id = aws_subnet.lb_subnet_a.id
  route_table_id = aws_route_table.lb_route.id
}

resource "aws_route_table_association" "public_route_b" {
  subnet_id = aws_subnet.lb_subnet_b.id
  route_table_id = aws_route_table.lb_route.id
}