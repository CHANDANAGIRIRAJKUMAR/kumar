module "ec2_module"{
  source = "./ec2_instance_module"
  web_ami_id= "ami-0cf2b4e024cdb6960"
  web_instance_type="t2.micro"
  subnet_id = module.vpc_module.my_public_subnet1
  enviornment="prod"
}
module "vpc_module"{
  source = "./vpc_module"
  cidr_block = "10.0.0.0/16"
  my_subnet1 = "10.0.3.0/24"
  my_subnet2 = "10.0.4.0/24"
  envirolment="prod"
}
