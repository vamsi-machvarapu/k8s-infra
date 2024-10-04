data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "private_subnet_zone1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_zone1_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
  enable_dns64                                   = false #default it's false
  enable_resource_name_dns_a_record_on_launch    = false #default it's false
  enable_resource_name_dns_aaaa_record_on_launch = false #default it's false
  depends_on = [ aws_vpc.vpc ]
  map_public_ip_on_launch                        = false  #default it's false, Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  tags = {
    Name = "${local.app}-${local.env}-private-subnet-zone1"
    Iac = "terraform"
    env = "${local.env}"
  }
}

resource "aws_subnet" "private_subnet_zone2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_zone2_cidr_block
  availability_zone = data.aws_availability_zones.available.names[1]
  enable_dns64                                   = false #default it's false
  enable_resource_name_dns_a_record_on_launch    = false #default it's false
  enable_resource_name_dns_aaaa_record_on_launch = false #default it's false
  map_public_ip_on_launch                        = false  #default it's false, Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  depends_on = [ aws_vpc.vpc ]
  tags = {
    Name = "${local.app}-${local.env}-private-subnet-zone2"
    Iac = "terraform"
    env = "${local.env}"
  }
}

resource "aws_subnet" "public_subnet_zone1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_zone1_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
  enable_dns64                                   = false #default it's false
  enable_resource_name_dns_a_record_on_launch    = false #default it's false
  enable_resource_name_dns_aaaa_record_on_launch = false #default it's false
  map_public_ip_on_launch                        = true  #default it's false, Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  depends_on = [ aws_vpc.vpc ]
  tags = {
    Name = "${local.app}-${local.env}-public-subnet-zone1"
    Iac = "terraform"
    env = "${local.env}"
  }
}

resource "aws_subnet" "public_subnet_zone2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_zone2_cidr_block
  availability_zone = data.aws_availability_zones.available.names[1]
  enable_dns64                                   = false #default it's false
  enable_resource_name_dns_a_record_on_launch    = false #default it's false
  enable_resource_name_dns_aaaa_record_on_launch = false #default it's false
  map_public_ip_on_launch                        = true  #default it's false, Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  depends_on = [ aws_vpc.vpc ]
  tags = {
    Name = "${local.app}-${local.env}-public-subnet-zone2"
    Iac = "terraform"
    env = "${local.env}"
  }
}