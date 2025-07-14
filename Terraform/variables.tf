# Global Variables
variable "region" {
  description = "AWS region"
  type        = string
}

variable "az" {
  description = "AWS availability zone"
  type        = string
}

# Network Variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnet configurations"
  type = list(object({
    name       = string
    cidr_block = string
    type       = string # "public" or "private"
    az         = string
  }))
}

# EC2 Variables
variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "public_key_path" {
  description = "Path to the SSH public key to provision EC2"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

variable "master_private_ip" {
  type        = string
  description = "Private IP of Jenkins Master EC2"
}

variable "slave_private_ip" {
  type        = string
  description = "Private IP of Jenkins Slave EC2"
}
