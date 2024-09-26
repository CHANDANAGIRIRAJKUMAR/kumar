data "template_file" "userdata" {
  template = file("userdata.sh")
}
resource "aws_instance" "web_instance" {
  ami           = var.web_ami_id
  instance_type = var.web_instance_type
  user_data = data.template_file.userdata.rendered
  subnet_id = var.subnet_id
  security_groups = [var.security_group]
  tags = {
    Name = "${var.enviornment}-server" #de/prod server (commonds are terraform apply -var-file dev.tsvars)
  }
}




