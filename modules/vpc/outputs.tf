output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
output "vpc_name" {
  value = var.vpc_name
}
