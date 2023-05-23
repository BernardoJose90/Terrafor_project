variable "access_key" {
  default   = "AKIA2IBQ5UZBR7IIXNHD"
  sensitive = true
}

variable "secret_key" {
  default   = "hbBEUmWmOq8JY3mYgEJIFAGUnsaZbUsuOK4vSSXe"
  sensitive = true
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-1"
}