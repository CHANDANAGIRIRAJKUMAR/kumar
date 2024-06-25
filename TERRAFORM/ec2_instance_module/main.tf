data "template_file" "userdata" {
  template = file("userdata.sh")
}
resource "aws_instance" "web_instance" {
  ami           = var.web_ami_id
  instance_type = var.web_instance_type
  user_data = data.template_file.userdata.rendered

  tags = {
    Name = "${var.enviornment}-serber" #de/prod server (commonds are terraform apply -var-file dev.tsvars)
  }
}

