variable "project" {
  description = "Project Name"
  type        = string
  default = "Terraform-Project"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for the VPC"
  type        = string
}
variable "private_subnets" {
  description = "List of private subnets for the VPC"
  type        = string
}
