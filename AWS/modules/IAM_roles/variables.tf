# Variable for IAM Role
variable "aws_iam_role" {
    description = "Variables for aws_iam_role.ec2_role"
    sensitive = false
    type = object({
        name = string
        description = string
        tags = map(string) 
    })   
    default = {
        name = "ec2_role"
        description = "Role for EC2"
        tags = {
            type = "Role for ec2_role"
        }
    }
}

# Variable for IAM Role Policy
variable "aws_iam_role_policy" {
    description = "Variables for aws_iam_role_policy.ec2_role_policy"
    sensitive = false
    default = {
        name = "ec2_role_policy"
    }
}

# Variable for IAM instance profile
variable "aws_iam_instance_profile" {
    description = "Variables for aws_iam_instance_profile.ec2_instanceprofile"
    sensitive = false
    type = object({
        name = string
        tags = map(string) 
    })
    default = {
        name = "ec2_instanceprofile"
        tags = {
            type = "Instance profile for ec2_role"
        }
    }
}