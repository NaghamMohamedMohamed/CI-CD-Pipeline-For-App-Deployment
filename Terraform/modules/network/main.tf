######################################
#                VPC
######################################

# Main Virtual Private Cloud (VPC)
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

######################################
#      Public & Private Subnets
######################################

# Create subnets based on input variable `var.subnets`
resource "aws_subnet" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = "${var.region}${each.value.az}"
  map_public_ip_on_launch = each.value.type == "public"  # Automatically assign public IP for public subnets

  tags = {
    Name = each.value.name
  }
}

######################################
#         Internet Gateway
######################################

# Enables internet access for public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

######################################
#        Public Route Table
######################################

# Route table for public subnets with default route to Internet Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"                # All outbound traffic
    gateway_id = aws_internet_gateway.igw.id  # Goes through IGW
  }

  tags = {
    Name = "${var.prefix}-public-rt"
  }
}

######################################
#   Public Route Table Association
######################################

# Associates public subnets with the public route table
resource "aws_route_table_association" "public_rta" {
  for_each = {
    for name, subnet in aws_subnet.subnets : name => subnet
    if var.subnets[index(keys(aws_subnet.subnets), name)].type == "public"
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}


######################################
#           Elastic IP
######################################

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = { Name = "${var.prefix}nat-eip" }
}


######################################
#          Nat Gateway
######################################

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnets["public-subnet-1"].id

  tags          = { Name = "${var.prefix}-gateway" }

  depends_on = [aws_internet_gateway.igw]
}

######################################
#        Private Route Table
######################################

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags   = { 
    Name = "${var.prefix}-private-rt" 
  }
}

######################################
#   Private Route Table Association
######################################

resource "aws_route_table_association" "private_rta" {
  for_each = {
    for name, subnet in aws_subnet.subnets : name => subnet
    if var.subnets[index(keys(aws_subnet.subnets), name)].type == "private"
  }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}