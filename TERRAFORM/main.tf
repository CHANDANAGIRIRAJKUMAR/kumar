module "vpc_module" {
  source = "./vpc_module"
  cidr_block = "10.0.0.0/16"
  my_subnet1 = "10.0.1.0/24"
  my_subnet2 = "10.0.2.0/24"
  envirolment = "dev"
}
module "ec2_module" {
  source = "./ec2_instance_module"
  web_ami_id= "ami-0e86e20dae9224db8"
  web_instance_type="t2.micro"
  subnet_id = module.vpc_module.my_public_subnet1
  enviornment ="dev"
  security_group = module.vpc_module.security_groups
}
