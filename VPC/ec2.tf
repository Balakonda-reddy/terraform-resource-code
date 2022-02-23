# for security group


resource "aws_security_group" "vpc-bastion-sg" {
  name        = "vpc-bastion-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

 ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["103.110.170.86/32"]
  }

 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-bastion-sg"
  }
}


resource "aws_security_group" "vpc-apache-sg" {
  name        = "vpc-apache-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

 ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    # cidr_blocks      = ["103.110.170.86/32"]
    security_groups = [aws_security_group.vpc-bastion-sg.id]
  }

#  ingress {
#     description      = "TLS from VPC"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     security_groups = [aws_security_group.vpc-bastion-sg.id]

#   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-apache-sg"
  }
}


# for key pair purpose

resource "aws_key_pair" "key" {
  key_name   = "k1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeAIhH1gFXTS/wpPyx0gpfjEqjMLEa1nGCnGq0odQoU7Bj0Smn9zrGv/p20gaWZ6sQIP5NlhT58B92PvVMhncXs0gGkfST6EJOtbZHxBSwcPrqOuO2pRHujA9ZB8kgjwWJEiRHuESgi85ef87zzudv52NaRRfzlIffC39Gl7zDvChroydjXm5WHiGY2klzIohdXVJck5hD/mXMb97fktwD9UEqhrbRd501MHJHnL/ubr6AXBznDOa+2DniIyD8xTu1/j1qvFA5JkoS/N3IEd8BCwe1xFPlULW7Aaibk1w25AopmpLcp4E/ykYw5FbYm/6Or5+r2hAWuHu6Kx5e0tgiOTqnI65SiWuPWRvlaHQuwAAtACjjier9KG01FrC/jZkRrfdtlFHlIY4nvEWGfJRlqcwxhX6dtdMRUQ/QZqV/o2Ukn9RQObPmvVahGkQmgmDIYCWZr4AFtmUzLwu2efaAWS9SWf96mMFRraG6MmEwk2hOApJOtCkQ1YkZVsAcq5s= china@BALU"
}

# for instance purpose

# FOR EC2 1

resource "aws_instance" "bastion" {
    ami = "ami-08e4e35cccc6189f4"
    instance_type = "t2.micro"
    key_name = "k1"
    vpc_security_group_ids = [aws_security_group.vpc-bastion-sg.id]
    subnet_id = aws_subnet.pub-sub1a.id
    # user_data = <<EOF

    # #!/bin/bash
    # yum update -y
    # yum install httpd -y 
    # systemctl enable httpd
    # systemctl start httpd
    # mkdir -p  /var/www/html/chess/
    # echo "this is chess" >/var/www/html/chess/index.html

    # EOF 

    tags = {
        Name = "bastion"
    }
}

# FOR EC2 2

resource "aws_instance" "apache" {
    ami = "ami-08e4e35cccc6189f4"
    instance_type = "t2.micro"
    key_name = "k1"
    vpc_security_group_ids = [aws_security_group.vpc-apache-sg.id]
    subnet_id = aws_subnet.pri-sub1a.id
    user_data = <<EOF

    #!/bin/bash
    yum update -y
    yum install httpd -y 
    systemctl enable httpd
    systemctl start httpd
    mkdir -p  /var/www/html/sudoku/
    echo "this is sudoku" >/var/www/html/sudoku/index.html

    EOF 

    tags = {
        Name = "apache"
    }
}

