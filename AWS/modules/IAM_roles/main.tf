# Create IAM Role
resource "aws_iam_role" "ec2_role" {
  name = var.aws_iam_role["name"]
  description = var.aws_iam_role["description"]
  assume_role_policy = file("${path.module}/trust_document/trust_ec2_role.json")
  tags = var.aws_iam_role["tags"]
}

# Create IAM Role Policy
resource "aws_iam_role_policy" "ec2_role_policy" {
  name = var.aws_iam_role_policy["name"]
  role = aws_iam_role.ec2_role.id
  policy = file("${path.module}/policy_documents/ec2_role_fullaccess.json")
}

# Create IAM instance profile
resource "aws_iam_instance_profile" "ec2_instanceprofile" {
  name  = var.aws_iam_instance_profile["name"]
  role = aws_iam_role.ec2_role.name
  tags = var.aws_iam_instance_profile["tags"]
}