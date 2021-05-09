# Output for VPC
output "output_VPC" {
    description = "Output for VPC"
    value = aws_vpc.andr_vpc
    sensitive   = false
}

# Output for Internet Gateway
output "output_Internet_Gateway" {
    description = "Output for Internet Gateway"
    value = aws_internet_gateway.andr_internet_gateway
    sensitive   = false
}

# Output forRoute Table
output "output_Route_Table" {
    description = "Output for Route Table"
    value = aws_route.andr_route
    sensitive   = false
}