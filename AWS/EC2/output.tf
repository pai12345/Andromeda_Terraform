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