resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy                     = "default" #The only other option is dedicated
  enable_dns_hostnames                 = true      #default it's true
  enable_dns_support                   = true      #default it's true
  enable_network_address_usage_metrics = false     #default it's false
  tags = {
    Name = "${local.app}-${local.env}-vpc"
    Iac = "terraform"
    env = "${local.env}"
  }
}