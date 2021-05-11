# dynamic variable for aws_key_pair
variable "aws_key_pair" {
  description = "Public Key for aws instance"
}

# default variable for aws_key_pair
variable "aws_keypair_tag" {
  description = "Details for Public Key for aws instance"
  default = {
    tags = {
      type = "Andromeda_Key_Pair"
    }
  }
}

# variable for aws_ami_ubuntu
variable "aws_ami_ubuntu" {
  description = "Data for aws ami - ubuntu"
  type = object({
    most_recent = bool
    os_type = object({
      name = string
      values = list(string)
    })
    virtualization = object({
      name = string
      values = list(string)
    })
    owners = list(string)
  })
  default = {
    most_recent = true
    os_type = {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210223"]
    }
    virtualization = {
      name   = "virtualization-type"
      values = ["hvm"]
    }
    owners = ["099720109477"]
  }
}

# variable for aws_vpc
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
    cidr_block = "0.0.0.0/0"
    instance_tenancy = "default"
    enable_dns_support = false
    enable_dns_hostnames = false
    tags = {
      type = "Andromeda_VPC"
    }
  }
}

# variable for aws_internet_gateway
variable "aws_internet_gateway" {
  type = object({
    tags = map(string)
  })
  default = {
    tags = {
      Name = "Andromeda_Internet_Gateway"
    }
  }
}

# variable for aws_route
variable "aws_route" {
  description = "Data for aws route"
  default = {
    destination_cidr_block = "0.0.0.0/0"
  }
}

# variable for aws_subnet
variable "aws_subnet" {
  description = "Data for aws subnet"
  type = object({
    cidr_block = string
    map_public_ip_on_launch = bool
    tags = map(string)
  })
  default = {
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags = {
      Name = "Andromeda_Subnet"
    }
  }
}

# variable for aws_security_group for ssh
variable "ssh_secgrp" {
  description = "Data for aws security group for EC2 ssh"
  type = object({
    name = string
    description = string
    ssh_ingress = object({
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    })
    egress = object({
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    })
    tags = map(string)
  })
  default = {
  name  = "ssh_secgrp"
  description = "aws security group for EC2 SSH"
  ssh_ingress = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Andromeda_SSH_Security_Group"
  }
  }
}

# variable for aws_security_group for http
variable "http_secgrp" {
  description = "Data for aws security group for EC2 http"
  type = object({
    name = string
    description = string
    http_ingress = object({
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    })
    egress = object({
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    })
    tags = map(string)
  })
  default = {
    name  = "http_secgrp"
    description = "aws security group for EC2 HTTP"
    http_ingress = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "Andromeda_HTTP_Security_Group"
    }
  }
}

# variable for aws_instance
variable "aws_instance" {
  description = "Data for aws ec2 instance"
  type = object({
    instance_type = string
    tags = map(string)
  })
  default = {
    instance_type = "t2.micro"
    tags = {
      Name = "Andromeda_EC2"
    }
  }
}

# variable for vpc_id
variable "vpc_id"{
  description = "Data for VPC id"
}

variable "iam_instance_profile"{
  description = "Data for IAM Instance Profile"
}