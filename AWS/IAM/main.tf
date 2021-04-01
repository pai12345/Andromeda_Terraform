#===================IAM User=================#
module "iam_generate_usergroups"{
   source = "../modules/IAM"
   variable_iam_user = var.variable_iam_user
}