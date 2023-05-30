/* create a IGW */
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.testvpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}

/* adds a IGW route to a public route table */
resource "aws_route" "public_igw_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  timeouts {
    create = "5m"
  }
}