
resource "aws_subnet" "pub-sub1a" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub1a"
  }
}


resource "aws_subnet" "pub-sub2a" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "pub-sub2a"
  }
}

resource "aws_subnet" "pri-sub1a" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "pri-sub1b"
  }
}


resource "aws_subnet" "pri-sub2a" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "pri-sub2a"
  }
}
