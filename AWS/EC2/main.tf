#===================IAM Role for EC2=================#
module "generate_ec2_role"{
   source = "../modules/IAM_roles"
}

#===================EC2 Instance=================#
module "generate_ec2_instance"{
   source = "../modules/EC2"
   aws_key_pair = var.aws_key_pair
   depends_on = [ module.generate_ec2_role ]
}