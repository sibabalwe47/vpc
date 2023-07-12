


module "vpc" {
  source                             = "terraform-aws-modules/vpc/aws"
  name                               = var.name
  cidr                               = var.vpc_cidr
  azs                                = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets                     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets                    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  database_subnets                   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]
  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  enable_nat_gateway                 = true
  single_nat_gateway                 = true
  default_vpc_enable_dns_hostnames   = true
  default_vpc_enable_dns_support     = true
  map_public_ip_on_launch            = true
  enable_vpn_gateway                 = false


  public_subnet_tags = {
    Name = "public-subnet-${var.name}"
  }

  private_subnet_tags = {
    Name = "private-subnet-${var.name}"
  }

  database_subnet_tags = {
    Name = "database-subnet-${var.name}"
  }
}
