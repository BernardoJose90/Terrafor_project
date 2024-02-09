/* Data resource to query the available AZs within a Region*/
data "aws_availability_zones" "available" {
  state = "available"
}

/* Create a VPC names testvpc*/
resource "aws_vpc" "testvpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.project}-vpc"
    Environment = terraform.workspace
  }

}