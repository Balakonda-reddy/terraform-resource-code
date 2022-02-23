
# PUBLIC ROUTE TABLE

resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pub-route"
  }
}



resource "aws_route_table_association" "pub-as1" {
  subnet_id      = aws_subnet.pub-sub1a.id
  route_table_id = aws_route_table.pub-route.id
}

resource "aws_route_table_association" "pub-as2" {
  subnet_id      = aws_subnet.pub-sub2a.id
  route_table_id = aws_route_table.pub-route.id
}


# PRIVATE ROUTE TABLE

resource "aws_route_table" "pri-route" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "pri-route"
  }
}


resource "aws_route_table_association" "pri-as1" {
  subnet_id      = aws_subnet.pri-sub1a.id
  route_table_id = aws_route_table.pri-route.id
}

resource "aws_route_table_association" "pri-as2" {
  subnet_id      = aws_subnet.pri-sub2a.id
  route_table_id = aws_route_table.pri-route.id
}

