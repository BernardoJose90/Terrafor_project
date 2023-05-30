
module "create_pvc" {
  source = "../modules/vpc"
  cidr_block = "10.0.0.0/16 "
  public_subnets = "10.0.90.0/24"
  private_subnets = "10.0.100.0/24"
}