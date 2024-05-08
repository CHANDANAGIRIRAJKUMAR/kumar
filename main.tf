resource "aws_instance" "web_instance" {
  ami           = var.web_ami_id
  instance_type = var.web_instance_type
  subnet_id = var.subnet_id
  security_groups = [var.my_security_groups]
  user_data = file("/home/ubuntu/install_apache.sh")

  tags = {
    name = "${var.enviornment}-serber" #de/prod server (commonds are terraform apply -var-file dev.tsvars)
  }
}

