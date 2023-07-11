
resource "aws_vpc" "random" {
  name                 = "vpc-test"
  enable_dns_hostnames = true
  enable_dns_support   = true
  cidr_block           = "10.0.0.0/16"
}
