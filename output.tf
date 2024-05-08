output "subnet_id1"{
    value =  aws_subnet.my_subnet1.id
}
output "subent_id2"{
    value = aws_subnet.my_subnet2.id
}
output "my_security_group_id"{
    value = aws_security_group.my_security_group.id
}