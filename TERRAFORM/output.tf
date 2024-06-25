output "instance_id" {
    value = module.ec2_module.output_name
}
output "instance_state" {
    value = module.ec2_module.instance_state
}
