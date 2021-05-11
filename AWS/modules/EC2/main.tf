# Fetch ubuntu 20.04 ami. This image will be used when creating EC2 Instance.
data "aws_ami" "ubuntu" {
  most_recent = var.aws_ami_ubuntu["most_recent"]
  filter {
    name   = var.aws_ami_ubuntu["os_type"]["name"]
    values = var.aws_ami_ubuntu["os_type"]["values"]
  }
  filter {
    name   = var.aws_ami_ubuntu["virtualization"]["name"]
    values = var.aws_ami_ubuntu["virtualization"]["values"]
  }
  owners = var.aws_ami_ubuntu["owners"]
}

# Fetch nginx configuration file
data "template_file" "client" {
  template = file("../modules/EC2/nginx_configure.sh")
}

# # Fetch IAM instance profile
# data "aws_iam_instance_profile" "iam_role_ec2" {
#   name = "ec2_instanceprofile"
# }

# # Create VPC to launch the instances into
# resource "aws_vpc" "default" {
#   cidr_block = var.aws_vpc["cidr_block"]
#   instance_tenancy = var.aws_vpc["instance_tenancy"]
#   enable_dns_support = var.aws_vpc["enable_dns_support"]
#   enable_dns_hostnames = var.aws_vpc["enable_dns_hostnames"]
#   tags = var.aws_vpc["tags"]
# }

# # Create internet gateway to give subnet access to the outside world
# resource "aws_internet_gateway" "default" {
#   vpc_id = aws_vpc.default.id
#   tags = var.aws_internet_gateway["tags"]
# }

# Fetch Public Key
resource "aws_key_pair" "web" {
  public_key = file(var.aws_key_pair)
  tags = var.aws_keypair_tag["tags"]
}

# # Grant VPC internet access on its main route table
# resource "aws_route" "internet_access" {
#   route_table_id         = aws_vpc.default.main_route_table_id
#   destination_cidr_block = var.aws_route["destination_cidr_block"]
#   gateway_id             = aws_internet_gateway.default.id
# }

# Create Subnet to launch the instances into
resource "aws_subnet" "default" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.aws_subnet["cidr_block"]
  map_public_ip_on_launch = var.aws_subnet["map_public_ip_on_launch"]
  tags = var.aws_subnet["tags"]
}

# Security group to access the instances over SSH
resource "aws_security_group" "ssh_secgrp" {
  name        = var.ssh_secgrp["name"]
  description = var.ssh_secgrp["description"]
  vpc_id      = var.vpc_id

  # SSH access
  ingress {
    from_port   = var.ssh_secgrp["ssh_ingress"]["from_port"]
    to_port     = var.ssh_secgrp["ssh_ingress"]["to_port"]
    protocol    = var.ssh_secgrp["ssh_ingress"]["protocol"]
    cidr_blocks = var.ssh_secgrp["ssh_ingress"]["cidr_blocks"]
  }

  # Outbound Access
  egress {
    from_port   = var.ssh_secgrp["egress"]["from_port"]
    to_port     = var.ssh_secgrp["egress"]["to_port"]
    protocol    = var.ssh_secgrp["egress"]["protocol"]
    cidr_blocks = var.ssh_secgrp["egress"]["cidr_blocks"]
  }
  tags = var.ssh_secgrp["tags"]
}

# Security group to access the instances over HTTP
resource "aws_security_group" "http_secgrp" {
  name        = var.http_secgrp["name"]
  description = var.http_secgrp["description"]
  vpc_id      = var.vpc_id

  # HTTP access
  ingress {
    from_port   = var.http_secgrp["http_ingress"]["from_port"]
    to_port     = var.http_secgrp["http_ingress"]["to_port"]
    protocol    = var.http_secgrp["http_ingress"]["protocol"]
    cidr_blocks = var.http_secgrp["http_ingress"]["cidr_blocks"]
  }

  # Outbound Access
  egress {
    from_port   = var.http_secgrp["egress"]["from_port"]
    to_port     = var.http_secgrp["egress"]["to_port"]
    protocol    = var.http_secgrp["egress"]["protocol"]
    cidr_blocks = var.http_secgrp["egress"]["cidr_blocks"]
  }
  tags = var.http_secgrp["tags"]
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
  vpc_security_group_ids = [aws_security_group.ssh_secgrp.id,aws_security_group.http_secgrp.id]

  # Adding Subnet details. 
  subnet_id = aws_subnet.default.id

  # Attach role
  iam_instance_profile = var.iam_instance_profile
  
  # Tags
  tags = var.aws_instance["tags"]

  # Load Web Server
  user_data = data.template_file.client.rendered
}