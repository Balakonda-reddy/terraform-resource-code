resource "aws_security_group" "ec2" {
  name        = "ec2"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-379d4d5c"

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2"
  }
}

resource "aws_instance" "apache" {
  count = 3
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
  key_name = "k1"
  # vpc_security_group_ids = ["sg-5589f52b"]
  security_groups = [aws_security_group.ec2.name]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "apache - ${count.index}"
  }
}

