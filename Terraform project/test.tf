variable "ami" {
  description = "Amazon machine image to use for ec2 instance"
  type = string
  default = "ami-02358d9f5245918a3"
}
variable "instance_type"{
    description = "ec2 instance type"
    type = string
    default = "t2.micro"
}

resource "aws_vpc" "saka" {
    cidr_block = "10.0.0.0/16"
    
    tags = {
        Name = "Saka VPC"
    }
}


resource "aws_internet_gateway" "sakagateway" {
  vpc_id = aws_vpc.saka.id

  tags = {
    Name = "Saka Gateway"
  }
}


resource "aws_subnet" "sakasubnet" {
    vpc_id = aws_vpc.saka.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "Saka Subnet"
    }
}


resource "aws_route_table" "sakaroutetable" {
  vpc_id = aws_vpc.saka.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sakagateway.id
  }

  tags = {
    Name = "Saka Route Table"
  }
}


resource "aws_route_table_association" "rt_subnet" {
  subnet_id      = aws_subnet.sakasubnet.id
  route_table_id = aws_route_table.sakaroutetable.id
}

resource "aws_security_group" "sakasecuritygroup" {
  name        = "Allow SSH & ICMP Traffic"
  description = "Allows all SSH and ICMP traffic."
  vpc_id      = aws_vpc.saka.id

  ingress {
    description      = "SSH."
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    description      = "ICMP."
    from_port        = 0
    to_port          = 0
    protocol         = "all"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SAKA SG"
  }
}

resource "aws_instance" "Ansible_Master" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.sakasecuritygroup.id ]
    subnet_id = aws_subnet.sakasubnet.id
    associate_public_ip_address = true
    key_name = "centos7"
    tags = {
        Name = "Ansible_Master"
    }
}
resource "aws_instance" "Ansible1" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.sakasecuritygroup.id ]
    subnet_id = aws_subnet.sakasubnet.id
    associate_public_ip_address = true
    key_name = "centos7"
    tags = {
        Name = "Ansible1"
    }
}
resource "aws_instance" "Ansible2" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.sakasecuritygroup.id ]
    subnet_id = aws_subnet.sakasubnet.id
    associate_public_ip_address = true
    key_name = "centos7"
    tags = {
        Name = "Ansible2"
    }
}
resource "aws_instance" "Ansible3" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.sakasecuritygroup.id ]
    subnet_id = aws_subnet.sakasubnet.id
    associate_public_ip_address = true
    key_name = "centos7"
    tags = {
        Name = "Ansible3"
    }
}
resource "aws_s3_bucket" "sakabuck" {
    bucket = "sakaprojectbucks3"

    tags = {
        Name = "sakas3projectbuck"
    }
}