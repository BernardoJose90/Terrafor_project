/* Creates a public subnet */
resource "aws_subnet" "public" {
  /* count = length(var.public_subnets)*/

  vpc_id                  = aws_vpc.testvpc.id
  cidr_block              = var.public_subnets
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.project}-Public-Subnet"
    Environment = terraform.workspace
  }
}

/* Creates a privatesubnetss  */
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.testvpc.id
  cidr_block        = element(concat(var.private_subnets, [""]), count.index)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name        = "${var.project}-Private-Subnet"
    Environment = terraform.workspace
  }
}
