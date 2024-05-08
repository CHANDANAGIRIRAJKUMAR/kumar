module "vpc"{
  source = "./vpc_module"

}
module "ec2_module"{
  source = "./ec2_instance"
  web_ami_id= "ami-04b70fa74e45c3917"
  web_instance_type="t2.micro"
  subnet_id = module.vpc.subnet_id1
  my_security_groups = module.vpc.my_security_group_id
  enviornment="prod"
}