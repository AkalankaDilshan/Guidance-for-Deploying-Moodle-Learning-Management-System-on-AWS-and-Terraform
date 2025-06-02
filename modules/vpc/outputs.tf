output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
output "vpc_name" {
  value = var.vpc_name
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ec2_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "private_subnet_data_ids" {
  value = aws_subnet.private_data_subnet[*].id
}
