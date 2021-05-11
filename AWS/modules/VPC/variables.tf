# Variable for VPC
variable "aws_vpc" {
  description = "Data for vpc"
  type = object({
    cidr_block = string
    instance_tenancy = string
    enable_dns_support = bool
    enable_dns_hostnames = bool
    tags = map(string)
  })
  default = {
    cidr_block = "10.0.0.0/16",
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      type = "Andromeda_VPC"
    }
  }
}

# Variable for Internet Gateway
variable "aws_internet_gateway" {
  description = "Data for Internet Gateway"
  type = object({
    tags = map(string)
  })
  default = {
    tags = {
      type = "Andromeda_Internet_Gateway"
    }
  }
}

# Variable for Route Table
variable "aws_route" {
  description = "Data for aws route"
  default = {
    destination_cidr_block = "0.0.0.0/0"
  }
}