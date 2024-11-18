# VPC

resource "aws_vpc" "oisc" {

  cidr_block           = var.vpc_cidr

  enable_dns_support   = true

  enable_dns_hostnames = true

  tags = {

    Name = "${var.environment_name}-vpc"

  }

}
 
# Subnets Públicas

resource "aws_subnet" "public" {

  count                   = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.oisc.id

  cidr_block              = var.public_subnet_cidrs[count.index]

  availability_zone       = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {

    Name = "${var.environment_name}-public-subnet-${count.index + 1}"

  }

}
 
# Subnets Privadas

resource "aws_subnet" "private" {

  count                   = length(var.private_subnet_cidrs)

  vpc_id                  = aws_vpc.oisc.id

  cidr_block              = var.private_subnet_cidrs[count.index]

  availability_zone       = var.availability_zones[count.index]

  map_public_ip_on_launch = false

  tags = {

    Name = "${var.environment_name}-private-subnet-${count.index + 1}"

  }

}
 
# Tablas de Rutas Públicas

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.oisc.id

  tags = {

    Name = "${var.environment_name}-public-rt"

  }
 
  # Ruta predeterminada hacia el Internet Gateway

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id

  }

}
 
# Asociar la tabla de rutas públicas a todas las subnets públicas

resource "aws_route_table_association" "public" {

  count          = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id

}
 
# Tablas de Rutas Privadas (una por AZ para resiliencia)

resource "aws_route_table" "private" {

  count = length(var.private_subnet_cidrs)

  vpc_id = aws_vpc.oisc.id
 
  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat[count.index].id

  }
 
  tags = {

    Name = "${var.environment_name}-private-rt-${count.index + 1}"

  }

}
 
# Asociar cada tabla de rutas privada a su correspondiente subnet privada

resource "aws_route_table_association" "private" {

  count          = length(var.private_subnet_cidrs)

  subnet_id      = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private[count.index].id

}

 
