variable "project" {
  description = "Project Name"
  type        = string
  default = "Terraform-Project"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet for the VPC"
  type        = string
  default = "10.0.20.0/24"
}
variable "private_subnets" {
  description = "List of private subnet for the VPC"
  type        = list(string)
  default = ["10.0.30.0/24"]
}
