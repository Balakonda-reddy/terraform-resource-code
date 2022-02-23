
resource "aws_eip" "eip" {
  vpc      = true
}




resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub-sub1a.id

  tags = {
    Name = "nat"
  }
}

