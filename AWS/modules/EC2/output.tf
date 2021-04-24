# Address for Elastic Load Balancer
output "output_EC2" {
  description = "EC2 Instance Details"
  value = aws_instance.web
}