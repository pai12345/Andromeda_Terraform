resource "aws_security_group" "ec2_security_group" {
  name        = "security-group-ec2"
  description = "EC2 Security Group"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Type = "EC2 Server"
  }
}

resource "aws_vpc" "vpc_main" {
  cidr_block       = "0.0.0.0/0"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Type = "Security Group VPC"
  }
}