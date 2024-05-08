output "instance_id" {
    value = module.ec2_module.output_name
}
output "instance_state" {
    value = module.ec2_module.instance_state
}
output "my_security_group_id"{
    value = module.vpc.my_security_group_id
}