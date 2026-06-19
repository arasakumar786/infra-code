output  "vpc_id" {
  value = aws_vpc.test_vpc.id
}
output "vpc_cidr" {
  value = aws_vpc.test_vpc.cidr_block
}
output "subnet_ids" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id,
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
}