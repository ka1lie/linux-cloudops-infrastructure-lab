output "vpc_id" {
  value = aws_vpc.create_vpc.id
}

output "subnet_public_id" {
  value = aws_subnet.create_public_subnet.id
}

output "subnet_private_id" {
  value = aws_subnet.create_private_subnet.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "sg_id" {
  value = aws_security_group.security_group.id
}
