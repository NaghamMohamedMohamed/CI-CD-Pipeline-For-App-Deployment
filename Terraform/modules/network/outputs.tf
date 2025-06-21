output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.subnets : s.id if var.subnets[index(keys(aws_subnet.subnets), s.tags["Name"])].type == "public"]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.subnets : s.id if var.subnets[index(keys(aws_subnet.subnets), s.tags["Name"])].type == "private"]
}
