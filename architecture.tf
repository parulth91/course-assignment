resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
tags = {
    Name = "my_vpc"
}
}
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
}
resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
}
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
}
resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}
resource "aws_eip" "elastic_ip" {
  vpc      = true
}
resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public1.id
  depends_on = [aws_internet_gateway.gw]
}
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat.id
  }
}
resource "aws_route_table_association" "subnet_public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rtb.id
}
resource "aws_route_table_association" "subnet_public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rtb.id
}
resource "aws_route_table_association" "subnet_private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rtb.id
}
resource "aws_route_table_association" "subnet_private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rtb.id
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Security Group for Bastion EC2 instance"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "Allow from my IP"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["122.169.180.171/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Bastion" {
  subnet_id   = aws_subnet.public1.id
  ami           = "ami-08d4ac5b634553e16"
  instance_type = "t2.medium"
  key_name = "Yash_EC2_KVP"
  associate_public_ip_address = true
  security_groups = [aws_security_group.bastion_sg.id]
  tags = {
    Name = "Bastion"
  }
}

resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Security Group for Application EC2 instance"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "Allow from my public IPs"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.1.0/24","10.0.2.0/24"]
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "appEC2" {
  subnet_id   = aws_subnet.private1.id
  ami           = "ami-08d4ac5b634553e16"
  instance_type = "t2.medium"
  key_name = "Yash_EC2_KVP"
  security_groups = [aws_security_group.app_sg.id]
    tags = {
    Name = "app"
  }
}

resource "aws_instance" "Jenkins" {
  subnet_id   = aws_subnet.private1.id
  ami           = "ami-08d4ac5b634553e16"
  instance_type = "t2.medium"
  key_name = "Yash_EC2_KVP"
  security_groups = [aws_security_group.app_sg.id]
  tags = {
    Name = "Jenkins"
  }
}
