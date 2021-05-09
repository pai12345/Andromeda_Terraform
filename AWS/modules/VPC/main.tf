# Create VPC to launch the instances into
resource "aws_vpc" "andr_vpc" {
    cidr_block = var.aws_vpc["cidr_block"]
    instance_tenancy = var.aws_vpc["instance_tenancy"]
    enable_dns_support = var.aws_vpc["enable_dns_support"]
    enable_dns_hostnames = var.aws_vpc["enable_dns_hostnames"]
    tags = var.aws_vpc["tags"]
}

# Create internet gateway to give subnet access to the outside world
resource "aws_internet_gateway" "andr_internet_gateway" {
  vpc_id = aws_vpc.andr_vpc.id
  tags = var.aws_internet_gateway["tags"]
}

# Grant VPC internet access on its main route table
resource "aws_route" "andr_route" {
  route_table_id         = aws_vpc.andr_vpc.main_route_table_id
  destination_cidr_block = var.aws_route["destination_cidr_block"]
  gateway_id             = aws_internet_gateway.andr_internet_gateway.id
}