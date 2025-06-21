variable "ecr_repo_name" {
  type        = string
  description = "The name of the ECR repository"
  
}

variable "prefix" {
    description = "Prefix for resource naming"
    type        = string
}