# # Data Source for VPC
# data "aws_vpc" "andr_vpc" {
#     id = ""
#     state = "available"
#     tags = {
#         type = "Andromeda_VPC"
#     }
# }

# Create Subnet to launch the ELB
resource "aws_subnet" "elb_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.aws_subnet["cidr_block"]
  map_public_ip_on_launch = var.aws_subnet["map_public_ip_on_launch"]
  tags = {
      type = "ELB_Subnet"
  }
}

# Create Security Group for ELB
resource "aws_security_group" "elb_securitygroup" {
    name        = var.aws_security_group_elb["name"]
    description = var.aws_security_group_elb["description"]
    vpc_id      = var.vpc_id

    # Ingress Access
    ingress {
        from_port   = var.aws_security_group_elb["ingress"]["from_port"]
        to_port     = var.aws_security_group_elb["ingress"]["to_port"]
        protocol    = var.aws_security_group_elb["ingress"]["protocol"]
        cidr_blocks = var.aws_security_group_elb["ingress"]["cidr_blocks"]
    }

    # Egress Access
    egress {
        from_port   = var.aws_security_group_elb["egress"]["from_port"]
        to_port     = var.aws_security_group_elb["egress"]["to_port"]
        protocol    = var.aws_security_group_elb["egress"]["protocol"]
        cidr_blocks = var.aws_security_group_elb["egress"]["cidr_blocks"]
    }
    tags = {
        type = "Andromeda_ELB_Security_Group"
    }
}

# Create a HTTP Load Balancer
resource "aws_lb" "http_elb" {
  name               = var.http_elb["name"]
  internal           = var.http_elb["internal"]
  load_balancer_type = var.http_elb["load_balancer_type"]
  security_groups    = [aws_security_group.elb_securitygroup.id]
  subnets            = [aws_subnet.elb_subnet.id]
  idle_timeout = var.http_elb["idle_timeout"]
  enable_deletion_protection = var.http_elb["enable_deletion_protection"]
  enable_cross_zone_load_balancing = var.http_elb["enable_cross_zone_load_balancing"]
  enable_http2 = var.http_elb["enable_http2"]
  tags = var.http_elb["tags"]
}

# Create HTTP ELB Target Group
resource "aws_lb_target_group" "http_target_group" {
    name = var.http_target_group["name"]
    deregistration_delay = var.http_target_group["deregistration_delay"]
    health_check {
        enabled = var.http_target_group["health_check"]["enabled"]
        healthy_threshold = var.http_target_group["health_check"]["healthy_threshold"]
        interval = var.http_target_group["health_check"]["interval"]
        matcher = var.http_target_group["health_check"]["matcher"]
        path = var.http_target_group["health_check"]["path"]
        port = var.http_target_group["health_check"]["port"]
        protocol = var.http_target_group["health_check"]["protocol"]
        timeout = var.http_target_group["health_check"]["timeout"]
        unhealthy_threshold = var.http_target_group["health_check"]["unhealthy_threshold"]
    }
    load_balancing_algorithm_type = var.http_target_group["load_balancing_algorithm_type"]
    port = var.http_target_group["port"]
    protocol_version = var.http_target_group["protocol_version"]
    protocol = var.http_target_group["protocol"]
    slow_start = var.http_target_group["slow_start"]
    tags = var.http_target_group["tags"]
    target_type = var.http_target_group["target_type"]
    vpc_id = var.vpc_id
}

# Create a HTTP Load Balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "http_elb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.http_target_group.arn
  target_id        = var.target_id
  port             = var.http_elb_target_group_attachment["port"]
}

# Create a HTTP Load Balancer Listener
resource "aws_lb_listener" "http_elb_listener" {
    load_balancer_arn = aws_lb.http_elb.arn
    port              = 8080
    protocol          = "HTTP"
    default_action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/html"
            message_body = "<h1>Hello World Default<h1>"
            status_code  = 200
        }
    }
}

# Create a HTTP Load Balancer Listener Rule
resource "aws_lb_listener_rule" "http_elb_listener_rule" {
    listener_arn = aws_lb_listener.http_elb_listener.arn
    priority     = 1

    action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/html"
            message_body = "<h1>Hello World rule 1<h1>"
            status_code  = 200
        }
    }
    condition {
        host_header {
            values = ["*"]
        }
        http_request_method {
            values = ["GET"]
        }
         path_pattern {
            values = ["/rule1"]
        }
    }
}