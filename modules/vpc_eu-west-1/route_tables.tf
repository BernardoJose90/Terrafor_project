
/* Creates a public route table
  */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.testvpc.id

  tags = {
    Name = "${var.project}-Public-RT-${var.env}"
  }
}

/* Creates a private route table 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.testvpc.id

  tags = {
    Name = "${var.project}-rt-${var.env}"
  }
}

/* associate public subnets with public route table */
resource "aws_route_table_association" "public" {
  /* count = length(var.public_subnets)*/

  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

/* associate pivate subnets with public route table 
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}*/