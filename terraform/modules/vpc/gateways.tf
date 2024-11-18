# Internet Gateway

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.oisc.id

  tags = {

    Name = "${var.environment_name}-igw"

  }

}
 
# Elastic IP para el NAT Gateway

resource "aws_eip" "nat" {

  count = length(var.availability_zones)

  domain = "vpc"

  tags = {

    Name = "${var.environment_name}-nat-eip-${count.index + 1}"

  }

}
 
# NAT Gateway

resource "aws_nat_gateway" "nat" {

  count        = length(var.availability_zones)

  allocation_id = aws_eip.nat[count.index].id

  subnet_id     = aws_subnet.public[count.index].id

  tags = {

    Name = "${var.environment_name}-nat-${count.index + 1}"

  }

}

 
