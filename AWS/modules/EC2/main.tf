# Fetch ubuntu 20.04 ami. This image will be used when creating EC2 Instance.
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210223"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

# Create VPC to launch the instances into
resource "aws_vpc" "default" {
  cidr_block = var.aws_vpc["cidr_block"]
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    type = "andromeda_vpc"
  }
}

# Create internet gateway to give subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

# Fetch Public Key
resource "aws_key_pair" "web" {
  public_key = file(var.aws_key_pair)
}

# Grant VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = var.aws_route["destination_cidr_block"]
  gateway_id             = aws_internet_gateway.default.id
}

# Create Subnet to launch the instances into
resource "aws_subnet" "default" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.aws_subnet["cidr_block"]
  map_public_ip_on_launch = var.aws_subnet["map_public_ip_on_launch"]
}

# Security group to access the instances over SSH and HTTP
resource "aws_security_group" "ssh_http" {
  name        = var.aws_security_group_default["name"]
  description = var.aws_security_group_default["description"]
  vpc_id      = aws_vpc.default.id

  # SSH access
  ingress {
    from_port   = var.aws_security_group_default["ssh_ingress"]["from_port"]
    to_port     = var.aws_security_group_default["ssh_ingress"]["to_port"]
    protocol    = var.aws_security_group_default["ssh_ingress"]["protocol"]
    cidr_blocks = var.aws_security_group_default["ssh_ingress"]["cidr_blocks"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = var.aws_security_group_default["http_ingress"]["from_port"]
    to_port     = var.aws_security_group_default["http_ingress"]["to_port"]
    protocol    = var.aws_security_group_default["http_ingress"]["protocol"]
    cidr_blocks = var.aws_security_group_default["http_ingress"]["cidr_blocks"]
  }

  # Outbound Access
  egress {
    from_port   = var.aws_security_group_default["egress"]["from_port"]
    to_port     = var.aws_security_group_default["egress"]["to_port"]
    protocol    = var.aws_security_group_default["egress"]["protocol"]
    cidr_blocks = var.aws_security_group_default["egress"]["cidr_blocks"]
  }
}

# Create AWS EC2 instance
resource "aws_instance" "web" {
  # type of instance
  instance_type = var.aws_instance["instance_type"]
  
  # AMI for the instance
  ami = data.aws_ami.ubuntu.id

  # Adding the SSH keypair.
  key_name = aws_key_pair.web.id

  # Security group to allow HTTP and SSH access
  vpc_security_group_ids = [aws_security_group.ssh_http.id]

  # Adding Subnet details. 
  subnet_id = aws_subnet.default.id
}