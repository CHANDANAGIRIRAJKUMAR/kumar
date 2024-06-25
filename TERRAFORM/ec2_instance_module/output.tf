output "output_name" {
    value = "to access this ${var.enviornment} instance use this ${aws_instance.web_instance.public_ip} ip"
}
output "instance_state" {
    value = aws_instance.web_instance.instance_state
}