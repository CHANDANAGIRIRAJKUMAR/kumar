output "my_public_subnet1" {
  value = aws_subnet.my_subnet1.id
}
output "my_private_subnet2" {
  value = aws_subnet.my_subnet2.id
}
output "security_groups" {
  value = aws_security_group.my_security_group.id
}
