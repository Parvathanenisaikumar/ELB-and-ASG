resource "aws_vpc" "vpc" {
  tags = {
    Name = "terraform-vpc"
  }
  cidr_block           = "44.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
}

resource "aws_subnet" "subnet_one" {
  tags = {
    Name = "terraform-subnet-one"
  }
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "us-east-1c"
  cidr_block              = "44.0.0.0/24"
  map_public_ip_on_launch = "true"
}
resource "aws_subnet" "subnet_two" {
  tags = {
    Name = "terraform-subnet-two"
  }
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "us-east-1d"
  cidr_block              = "44.0.1.0/24"
  map_public_ip_on_launch = "true"
}

resource "aws_internet_gateway" "IG" {
  tags = {
    Name = "terraform-gateway"
  }
  vpc_id = aws_vpc.vpc.id
}
resource "aws_route_table" "route" {
  tags = {
    Name = "terraform-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "associate_1" {
  route_table_id = aws_route_table.route.id
  subnet_id      = aws_subnet.subnet_one.id
}
resource "aws_route_table_association" "associate_2" {
  route_table_id = aws_route_table.route.id
  subnet_id      = aws_subnet.subnet_two.id
}







