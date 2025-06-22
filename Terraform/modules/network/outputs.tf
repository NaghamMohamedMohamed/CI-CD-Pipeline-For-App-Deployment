output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.subnets["public-subnet-1"].id,
    aws_subnet.subnets["public-subnet-2"].id,
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.subnets["private-subnet-1"].id,
    aws_subnet.subnets["private-subnet-2"].id,
  ]
}
