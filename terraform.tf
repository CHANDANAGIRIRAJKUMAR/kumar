provider "aws" {
  region = "us-west-2"  # Set your desired AWS region
}

locals {
  common_tags = {
    Company = "Software Company"
    Project = "Apache-on-Ubuntu"
  }
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "MyVPC"
  })
}

# Create Subnets
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = merge(local.common_tags, {
    Name = "Subnet1"
  })
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = merge(local.common_tags, {
    Name = "Subnet2"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = merge(local.common_tags, {
    Name = "IGW"
  })
}

# Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "MyRouteTable"
  })
}

# Associate Route Table to Subnets
resource "aws_route_table_association" "subnet1_association" {
  route_table_id = aws_route_table.my_route_table.id
  subnet_id      = aws_subnet.subnet1.id
}

resource "aws_route_table_association" "subnet2_association" {
  route_table_id = aws_route_table.my_route_table.id
  subnet_id      = aws_subnet.subnet2.id
}

# Security Group
resource "aws_security_group" "sg" {
  name        = "sg_apache_on_ubuntu"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP_ADDRESS/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "SecurityGroup"
  })
}

# Create EC2 instance in each subnet
resource "aws_instance" "instance1" {
ami           = "ami-0c5202a14f3884861"
  instance_type = "t2.micro"
  key_name      = "your_key_pair"
  subnet_id     = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data     = <<-EOF               # Change Ubuntu user_data if needed
  #!/bin/bash
  sudo apt update
  sudo DEBIAN_FRONTEND=noninteractive apt install -y apache2
  sudo systemctl enable apache2
  sudo systemctl start apache2
  EOF

  tags = merge(local.common_tags, {
    Name = "Instance1"
  })
}

resource "aws_instance" "instance2" {
  ami           = "ami-0c5202a14f3884861"
  instance_type = "t2.micro"
  key_name      = "your_key_pair"
  subnet_id     = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data     = <<-EOF               # Change Ubuntu user_data if needed
  #!/bin/bash
  sudo apt update
  sudo DEBIAN_FRONTEND=noninteractive apt install -y apache2
  sudo systemctl enable apache2
  sudo systemctl start apache2
  EOF

  tags = merge(local.common_tags, {
    Name = "Instance2"
  })
}

# Output the instance public IP addresses
output "instance1_public_ip" {
  value = aws_instance.instance1.public_ip
}

output "instance2_public_ip" {
  value = aws_instance.instance2.public_ip
}
