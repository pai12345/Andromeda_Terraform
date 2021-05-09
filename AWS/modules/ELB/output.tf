# Output for ELB Subnet
output "output_elb_subnet" {
  description = "Output for ELB Subnet"
  value = aws_subnet.elb_subnet
}

# Output for ELB Security Group
output "output_elb_securitygroup" {
  description = "Output for ELB Security Group"
  value = aws_security_group.elb_securitygroup
}

# Output for ELB
output "output_http_elb" {
  description = "Output for HTTP ELB"
  value = aws_lb.http_elb
}

# Output for ELB Target Group
output "output_http_target_group" {
  description = "Output for ELB Target Group"
  value = aws_lb_target_group.http_target_group
}