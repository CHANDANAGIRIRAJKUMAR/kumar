variable "web_ami_id" {
    
    description = "ami_id of the instance"
    type = string
}

variable "web_instance_type" {

    description = "type of the instance"
    type = string
}
variable "enviornment" {
    description = "this is to  dev or prod  tags"
    type = string
}
