resource "aws_eip" "eip" {
  domain = "vpc"
  tags = {
    Name = "${local.app}-${local.env}-natgw-eip"
    Iac = "terraform"
    env = "${local.env}"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_subnet_zone2.id
  depends_on = [ aws_eip.eip, aws_subnet.public_subnet_zone2 ]
  tags = {
    Name = "${local.app}-${local.env}-natgw"
    Iac = "terraform"
    env = "${local.env}"
  }
}