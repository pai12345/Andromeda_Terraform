#===================Output Module iam_generate_usergroups=================#
output output_iam_generate_usergroups {
    value=module.iam_generate_usergroups
    sensitive = false
    description = "IAM User Groups created"
}