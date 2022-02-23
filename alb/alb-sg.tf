resource "aws_security_group" "alb-sg1" {
  name        = "alb-sg1"
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
    Name = "alb-sg1"
  }
}