resource "aws_vpc" "create_vpc" {
  cidr_block = var.vpc_subnet
  region = var.aws_region
  enable_dns_hostnames = true
  
  tags = {
    Name = "vpc-${var.environment}"
  }
}

resource "aws_subnet" "create_public_subnet" {
  vpc_id            = aws_vpc.create_vpc.id
  cidr_block        = var.public_subnet
  availability_zone = var.aws_AZ_region

  tags = {
    Name = "public-subnet-${var.environment}"
  }
}

resource "aws_subnet" "create_private_subnet" {
  vpc_id            = aws_vpc.create_vpc.id
  cidr_block        = var.private_subnet
  availability_zone = var.aws_AZ_region

  tags = {
    Name = "private-subnet-${var.environment}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.create_vpc.id
  region = var.aws_region

  tags = {
    Name = "igw-${var.environment}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.create_vpc.id
  region = var.aws_region

    tags = {
    Name = "public-table-${var.environment}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.create_vpc.id
  region = var.aws_region

    tags = {
    Name = "private-table-${var.environment}"
  }
}

resource "aws_route" "route_to_internet" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "assosciate_public_subnet" {
  subnet_id      = aws_subnet.create_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "assosciate_private_subnet" {
  subnet_id      = aws_subnet.create_private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "security_group" {
  vpc_id = aws_vpc.create_vpc.id
  name = "sec-group-${var.environment}"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.client_cidr]
  }
  tags = {
    Name = "sg-${var.environment}"
  }
}