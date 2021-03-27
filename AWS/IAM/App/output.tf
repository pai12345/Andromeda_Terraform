#===================IAM User=================#
output output_iam_user {
    value=aws_iam_user.iam_users
    sensitive = false
    description = "IAM User created"
}

#===================IAM Policy=================#
output output_iam_policy {
    value=aws_iam_policy.iam_policy
    sensitive = false
    description = "IAM Policy created"
}

#===================IAM Group=================#
output output_iam_group {
    value=aws_iam_group.iam_group
    sensitive = false
    description = "IAM Group Group"
}

#===================IAM User to Group=================#
output output_iam_user_group_membership {
    value=aws_iam_user_group_membership.iam_user_to_group
    sensitive = false
    description = "IAM User attached to Group"
}

#===================IAM Policy to Group=================#
output output_iam_attach_group_policy {
    value=aws_iam_group_policy_attachment.iam_attach_group_policy
    sensitive = false
    description = "IAM Policy attached to Group"
}