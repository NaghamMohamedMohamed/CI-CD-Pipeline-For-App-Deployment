# Global Configuration
prefix = "nodejs"
region = "us-east-1"
az     = "us-east-1a"

# VPC and Subnets
vpc_cidr             = "10.0.0.0/16"
subnets = [
  {
    name       = "public-subnet-1"
    cidr_block = "10.0.0.0/24"
    type       = "public"
    az         = "a"
  },
  {
    name       = "public-subnet-2"
    cidr_block = "10.0.1.0/24"
    type       = "public"
    az         = "b"

  },
  {

    name       = "private-subnet-1"
    cidr_block = "10.0.2.0/24"
    type       = "private"
    az         = "a"

  },
  {
    name       = "private-subnet-2"
    cidr_block = "10.0.3.0/24"
    type       = "private"
    az         = "b"

  }
]

# EC2 Configuration
key_name        = "ssh-key"
public_key_path = "../ssh-key.pub"
instance_type   = "t2.micro"
master_private_ip = "10.0.2.100" # Jenkins Master EC2
slave_private_ip = "10.0.2.150"  # Jenkins Slave EC2
