terraform {
  backend "s3" {
    bucket = "tf-backend-terraform2"
    key    = "terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
    dynamodb_table = "terraformtfstate"
  }
}

module "vpc_eu-west-1" {
  source = "./modules/vpc_eu-west-1"
}