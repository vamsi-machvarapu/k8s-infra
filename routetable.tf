resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  depends_on = [ aws_vpc.vpc, aws_internet_gateway.igw ]
  tags = {
    Name = "${local.app}-${local.env}-public-rt"
    Iac = "terraform"
    env = "${local.env}"
  }
}

resource "aws_route_table_association" "public_rt_association1" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_subnet_zone1.id
  depends_on = [ aws_route_table.public_rt, aws_subnet.public_subnet_zone1 ]
}

resource "aws_route_table_association" "public_rt_association2" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_subnet_zone2.id
  depends_on = [ aws_route_table.public_rt, aws_subnet.public_subnet_zone2 ]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  depends_on = [ aws_vpc.vpc, aws_nat_gateway.nat_gw ]
  tags = {
    Name = "${local.app}-${local.env}-private-rt"
    Iac = "terraform"
    env = "${local.env}"
  }
}

resource "aws_route_table_association" "private_rt_association1" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id = aws_subnet.private_subnet_zone1.id
  depends_on = [ aws_route_table.private_rt, aws_subnet.private_subnet_zone1 ]
}

resource "aws_route_table_association" "private_rt_association2" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id = aws_subnet.private_subnet_zone2.id
  depends_on = [ aws_route_table.private_rt, aws_subnet.private_subnet_zone2 ]
}