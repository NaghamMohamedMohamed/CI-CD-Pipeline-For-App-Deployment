variable "prefix" {
    description = "Prefix for resource naming"
    type        = string
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.network.private_subnet_ids
}

output "bastion_public_ip" {
  description = "Public IP of bastion"
  value       = module.ec2.bastion_public_ip
}

output "jenkins_master_private_ip" {
  value = var.master_private_ip
}

output "jenkins_slave_private_ip" {
  value = var.slave_private_ip
}

output "alb_dns_name" {
  description = "DNS name of the application load balancer"
  value       = module.alb.alb_dns_name
}

output "aws_ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.ecr_repo.repository_url
}

output "aws_ecr_repository_name" {
  description = "Name of the ECR repo"
  value = aws_ecr_repository.ecr_repo.name
}
