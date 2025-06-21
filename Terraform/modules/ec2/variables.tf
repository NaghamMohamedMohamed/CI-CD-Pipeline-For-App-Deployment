variable "prefix" {
  description = "A prefix for the created resources"
  type        = string
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair"
}

variable "public_key_path" {
  type        = string
  description = "Path to public key"
}

variable "bastion_sg_id" {
  type        = string
  description = "Bastion security group ID"
}

variable "jenkins_master_sg_id" {
  type        = string
  description = "Jenkins security group ID"
}

variable "jenkins_slave_sg_id" {
  type        = string
  description = "Jenkins Slave security group ID"
}

variable "app_sg_id" {
  type        = string
  description = "NodeJS APP security group ID"
}
