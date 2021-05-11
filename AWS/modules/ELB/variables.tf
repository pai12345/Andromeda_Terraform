# variable for aws_subnet
variable "aws_subnet" {
    description = "Data for aws subnet"
    type = object({
        cidr_block = string
        map_public_ip_on_launch = bool
    })
    default = {
        cidr_block = "10.0.0.0/24"
        map_public_ip_on_launch = true
    }
}

# variable for subnet_two
variable "subnet_two" {
    description = "Data for aws subnet 2"
    type = object({
        cidr_block = string
        map_public_ip_on_launch = bool
    })
    default = {
        cidr_block = "10.0.8.0/24"
        map_public_ip_on_launch = true
    }
}

# variable for aws_security_group_elb
variable "aws_security_group_elb" {
    description = "Data for ALB Security Group"
    type = object({
        name = string
        description = string
        ingress = object({
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
        name = "elb_securitygroup"
        description = "Security Group for ALB"
        ingress = {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        egress = {
            from_port   = 0
            to_port     = 0
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

# variable for aws_lb
variable "http_elb" {
    description = "Data for HTTP ELB"
    type = object({
        name = string
        internal = bool
        load_balancer_type = string
        idle_timeout = number
        enable_deletion_protection = bool
        enable_cross_zone_load_balancing = bool
        enable_http2 = bool
        tags = map(string)
    })
    default = {
        name               = "httpelb"
        internal           = false
        load_balancer_type = "application"
        idle_timeout = 400
        enable_deletion_protection = false
        enable_cross_zone_load_balancing = false
        enable_http2 = true
        tags = {
            type = "Andromeda_ALB"
            }
    }
}

#   health_check = object({
#             enabled = bool
#             healthy_threshold = number
#             interval = number
#             matcher = string
#             path = string
#             port = number
#             protocol = string
#             unhealthy_threshold = number
#         })

# variable for http_target_group
variable "http_target_group" {
    description = "Data for ELB Target Group"
    type = object({
        name = string
        deregistration_delay = number
        health_check = object({
            matcher = string
            path = string
            port = number
        })
        load_balancing_algorithm_type = string
        port = number
        protocol_version = string
        protocol = string
        slow_start = number
        tags = map(string)
        target_type = string
    })
    default = {
        name = "httptargetgroup"
        deregistration_delay = 300
        health_check = {
            # enabled = true
            # healthy_threshold = 3
            # interval = 5
            matcher = "200"
            path = "/"
            port = 80
            # protocol = "HTTP"
            # unhealthy_threshold = 3
        }
        load_balancing_algorithm_type = "round_robin"
        port = 80
        protocol_version = "HTTP1"
        protocol = "HTTP"
        slow_start = 0
        tags = {
            type = "ALB_EC2"
            }
        target_type = "instance"
    }
}

# variable for http_elb_target_group_attachment
variable "http_elb_target_group_attachment" {
    description = "Data for HTTP Load Balancer Target Group Attachment"
    default = {
        port = 80
    }
}

# # variable for http_elb_listener
# variable "http_elb_listener" {
#     description = "Data for Application Load Balancer Listener"
#     type = object({
#         port = number
#         protocol = string
#         default_action = object({
#             type = string
#             fixed_response = object({
#                 content_type = string
#                 message_body = string
#                 status_code = number
#             })
#         })
#     })
#     default = {
#         port              = 80
#         protocol          = "HTTP"
#         default_action  = {
#             type = "fixed-response"
#             fixed_response  = {
#                 content_type = "text/html"
#                 message_body = "<h1>Hello World Default<h1>"
#                 status_code  = 200
#             }
#         }
#     }
# }

# # variable for http_elb_listener_rule
# variable "http_elb_listener_rule" {
#     description = "Data for HTTP Load Balancer Listener Rule"
#     type = object({
#         priority = number
#         action = object({
#             type = string
#             fixed_response = object({
#                 content_type = string
#                 message_body = string
#                 status_code  = number
#             })
#         })
#         condition = object({
#             host_header = object({
#                 values = list(string)
#             })
#             http_request_method = object({
#                 values = list(string)
#             })
#             path_pattern = object({
#                 values = list(string)
#             })
#         })
#     })
#     default = {
#         priority     = 1
#         action = {
#             type = "fixed-response"
#             fixed_response = {
#                 content_type = "text/html"
#                 message_body = "<h1>Hello World rule 1<h1>"
#                 status_code  = 200
#             }
#         }
#         condition = {
#             host_header = {
#                 values = ["*"]
#             }
#             http_request_method = {
#                 values = ["GET"]
#             }
#             path_pattern = {
#                 values = ["/rule1"]
#             }
#         }
#     }
# }

# variable for vpc_id
variable "vpc_id" {
    description = "Data for VPC id"
}

# variable for vpc_id
variable "target_id" {
    description = "Data for instance id"
}