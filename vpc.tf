resource "aws_vpc" "terra" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "terra"
  }
}

resource "aws_subnet" "public-a" {
  vpc_id     = aws_vpc.terra.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "public-a"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id     = "${aws_vpc.terra.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "public-c"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id     = aws_vpc.terra.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "private-a"
  }
}

resource "aws_subnet" "private-c" {
  vpc_id     = aws_vpc.terra.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "private-c"
  }
}

resource "aws_internet_gateway" "vpc-gateway" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "vpc-gateway"
  }
}


resource "aws_route_table" "vpc-route" {
  vpc_id = aws_vpc.terra-vpc.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-gateway.id
  }

  tags = {
    Name = "vpc-route"
  }
}

resource "aws_main_route_table_association" "" {
    vpc_id = aws_vpc.terra-vpc.id
    route_table_id = aws_route_table.vpc-route.id
} 