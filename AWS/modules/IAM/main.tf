#===================Local Variables=================#
locals {
  user_generate = {for i,v in var.variable_iam_user: i =>v}
}


#===================IAM User=================#
resource "aws_iam_user" "iam_users"{
    for_each = local.user_generate
    name = each.value["name"]
    path = each.value["path"]
    force_destroy = each.value["force_destroy"]
    tags = each.value["tags"]
}

#===================IAM Policy=================#
resource "aws_iam_policy" "iam_policy" {
  name        = var.variable_iam_policy["name"] 
  path        = var.variable_iam_policy["path"] 
  description = var.variable_iam_policy["description"]
  policy = file("${path.module}/policy_documents/iam_policy.json")
}

#===================IAM Group=================#
resource "aws_iam_group" "iam_group" {
  name = var.variable_iam_group.name
  path = var.variable_iam_group.path
}


#===================IAM User to Group=================#
resource "aws_iam_user_group_membership" "iam_user_to_group" {
  for_each = {for i,v in var.variable_iam_user: i =>v}
  user = each.value["name"]
  groups = [
    aws_iam_group.iam_group.name
  ]
  depends_on = [
    aws_iam_user.iam_users,
    aws_iam_group.iam_group
  ]
}

#===================IAM Policy to Group=================#
resource "aws_iam_group_policy_attachment" "iam_attach_group_policy" {
  group      = aws_iam_group.iam_group.name
  policy_arn = aws_iam_policy.iam_policy.arn
  depends_on = [
    aws_iam_group.iam_group,
    aws_iam_policy.iam_policy
  ]
}