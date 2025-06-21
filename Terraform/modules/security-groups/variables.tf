variable "prefix" {
  description = "A prefix for the created resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to attach security groups"
  type        = string
}
