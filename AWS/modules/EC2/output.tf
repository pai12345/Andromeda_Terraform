# Output for EC2
output "output_EC2" {
  description = "Output for EC2 Instance"
  value = aws_instance.web
}

# # Output for VPC
# output "output_aws_vpc" {
#   description = "Output for VPC"
#   value = aws_vpc.default
# }

# # Output for Internet Gateway
# output "output_aws_internet_gateway" {
#   description = "Output for Internet Gateway"
#   value = aws_internet_gateway.default
# }

# # Output for Route
# output "output_aws_route" {
#   description = "Output for Route"
#   value = aws_route.internet_access
# }

# Output for Subnet
output "output_aws_subnet" {
  description = "Output for Subnet"
  value = aws_subnet.default
}

# Output for Security Group SSH
output "output_ssh_secgrp" {
  description = "Output for Security Group SSH"
  value = aws_security_group.ssh_secgrp
}

# Output for Security Group HTTP
output "output_http_secgrp" {
  description = "Output for Security Group HTTP"
  value = aws_security_group.http_secgrp
}