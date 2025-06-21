variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "prefix" {
    description = "A prefix for the created resources"
    type        = string
}

variable "public_subnet_ids" {
    description = "List of two IDs for the Public subnets"
    type = list(string)
}

variable "alb_sg_id" {
  description = "Security group ID for ALB"
  type        = string
}

variable "target_instance_id" {
  type = string
  description = "ID of the EC2 instance to attach to the target group"
}


