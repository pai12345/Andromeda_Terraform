#===================IAM Role=================#
output output_iam_role {
    value=aws_iam_role.ec2_role
    sensitive = false
    description = "IAM Role for EC2 created"
}

#===================IAM Role Policy=================#
output output_iam_role_policy {
    value=aws_iam_role_policy.ec2_role_policy
    sensitive = false
    description = "IAM Role Policy for EC2 created"
}

#===================IAM Instance Profile=================#
output output_iam_instance_profile {
    value=aws_iam_instance_profile.ec2_instanceprofile
    sensitive = false
    description = "IAM Instance Profile for EC2 created"
}