variable "web_ami_id" {
    
    description = "ami_id of the instance"
    type = string
}

variable "web_instance_type" {

    description = "type of the instance"
    type = string
}
variable "subnet_id"{
    description ="this is a public subnet01"
}
variable "enviornment" {
    description = "this is to provide tags"
    type = string
}
variable "my_security_groups"{
    description ="this is a security group cutom created"
}