variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "region" {
    description = "AWS region"
    type        = string
}

variable "prefix" {
    description = "Prefix for resource naming"
    type        = string
}

variable "subnets" {
    description = "Subnet definitions"
    type = list(object({
        name       = string
        cidr_block = string
        type       = string
        az         = string
    }))
}
