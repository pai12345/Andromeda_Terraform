#===================Generate VPC, Internet Gateway and Routing Table=================#
module "generate_vpc"{
   source = "../modules/VPC"
}

#===================IAM Role for EC2=================#
module "generate_ec2_role"{
   source = "../modules/IAM_roles"
}

#===================EC2 Instance=================#
module "generate_ec2_instance"{
   source = "../modules/EC2"
   aws_key_pair = var.aws_key_pair
   vpc_id = module.generate_vpc.output_VPC.id
   iam_instance_profile = module.generate_ec2_role.output_iam_instance_profile.name
   depends_on = [ module.generate_vpc, module.generate_ec2_role ]
}

#===================Generate HTTP ELB=================#
module "generate_http_elb"{
   source = "../modules/ELB"
   vpc_id = module.generate_vpc.output_VPC.id
   target_id = module.generate_ec2_instance.output_EC2.id
   depends_on = [ module.generate_vpc, module.generate_ec2_role, module.generate_ec2_instance ]
}