resource "aws_vpc" "vpc" {
  cidr_block = "10.9.0.0/16"

  tags = {
    Name = "VPC-ID"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.9.2.0/24"

  tags = {
    Name = "Subnet-ID"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Internet-Gateway-ID"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }  #For any traffic going outside the VPC (any IP address), send it to the Internet Gateway

  tags = {
    Name = "Route-Table-ID"
  }
}

#Associating the route table to the subnet
resource "aws_route_table_association" "public-ass" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.public.id
}