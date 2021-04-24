#===================EC2 Instance=================#
module "generate_ec2"{
   source = "../modules/EC2"
   aws_key_pair = var.aws_key_pair
}