# variable for aws_key_pair
variable "aws_key_pair" {
  description = "Public Key for aws instance"
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
    cidr_block = "10.0.0.0/16",
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      type = "andromeda_vpc"
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
  
  default = {
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
  }
}

# variable for aws_security_group_default
variable "aws_security_group_default" {
  description = "Data for aws security group for ssh and http"

  type = object({
    name = string
    description = string
    ssh_ingress = object({
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    })
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
  })
  
  default = {
  name  = "aws_security_group_default"
  description = "aws security group for ssh and http"
  ssh_ingress = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  http_ingress = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }
}

# variable for aws_instance
variable "aws_instance" {
  description = "Data for aws ec2 instance"
  default = {
    instance_type = "t2.micro"
  }
}