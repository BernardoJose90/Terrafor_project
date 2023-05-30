
/* Creates a public route table
  */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.testvpc.id

  tags = {
    Name = "${var.project}-Public-RT"
  }
}

/* Creates a private route table */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.testvpc.id

  tags = {
    Name = "${var.project}-Private-RT"
  }
}

/* associate public subnets with public route table */
resource "aws_route_table_association" "public" {
  /* count = length(var.public_subnets)*/

  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

/* associate private subnets with public route table*/
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.*.id
  route_table_id = aws_route_table.private.id
}