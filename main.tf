# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    name = "${var.enviornment}"
  }
}

# Create Subnet01
resource "aws_subnet" "my_subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet1_cidr
  availability_zone = "us-east-1a" # Set your desired availability zone
  map_public_ip_on_launch = true
}
# Create Subnet02
resource "aws_subnet" "my_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet2_cidr
  availability_zone = "us-east-1b" # Set your desired availability zone
}


# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Create Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Associate Subnet with Route Table
resource "aws_route_table_association" "my_subnet1_association" {
  subnet_id      = aws_subnet.my_subnet1.id
  route_table_id = aws_route_table.my_route_table.id
}
# Associate Subnet with Route Table
resource "aws_route_table_association" "my_subnet2_association" {
  subnet_id      = aws_subnet.my_subnet2.id
  route_table_id = aws_route_table.my_route_table.id
}
# Create Security Group
resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  # Ingress rules for SSH and HTTP (port 22 and 80)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

