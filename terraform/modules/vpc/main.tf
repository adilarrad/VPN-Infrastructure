resource "aws_vpc" "vpc" { 
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Project-VPC"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Project-Subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Project-Internet-Gateway"
  }
}

resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Project-Route-Table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route.id
}