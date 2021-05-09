#===================Output Module generate_vpc=====================#
output output_generate_vpc {
    value=module.generate_vpc
    sensitive = false
    description = "Output for Module - VPC, Internet Gateway and Routing Table"
}

#===================Output Module generate_ec2_role=================#
output output_generate_ec2_role {
    value=module.generate_ec2_role
    sensitive = false
    description = "Output for Module - IAM Role for EC2"
}

#===================Output Module generate_ec2_instance=================#
output output_generate_ec2_instance {
    value=module.generate_ec2_instance
    sensitive = false
    description = "Output for Module - EC2"
}

#===================Output Module generate_http_elb=================#
output output_generate_http_elb {
    value=module.generate_http_elb
    sensitive = false
    description = "Output for Module - HTTP ELB"
}