#===================Output Module iam_generate_usergroups=================#
output output_generate_ec2 {
    value=module.generate_ec2
    sensitive = false
    description = "Output for Module - EC2"
}