output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.testvpc.id
}

output "public_subnet" {
  description = "Public_Subnet"
  value       = aws_subnet.public
}

output "subnet_id" {
  value = aws_subnet.public.id
}
