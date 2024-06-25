variable "web_ami_id" {
    
    description = "ami_id of the instance"
    type = string
}

variable "web_instance_type" {

    description = "type of the instance"
    type = string
}
variable "subnet_id"{
    description = "subnet "    
}
variable "enviornment" {
    description = "this is to  dev or prod  tags"
    type = string
}
