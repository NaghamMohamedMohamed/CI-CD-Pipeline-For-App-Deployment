######################################
#       Security Groups 
######################################

# Security Group for the Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "${var.prefix}-bastion-sg"
  description = "Allow SSH from anywhere"
  vpc_id      = var.vpc_id

  # Inbound rule to allow SSH (port 22) from any IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic to any destination
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Jenkins Master Server
resource "aws_security_group" "master_sg" {
  name        = "${var.prefix}-jenkins-master-sg"
  description = "Allow web/SSH access to Jenkins Master from Bastion"
  vpc_id      = var.vpc_id

  # Allow SSH access (port 22) only from the bastion security group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Jenkins Slave
resource "aws_security_group" "slave_sg" {
  name        = "${var.prefix}-jenkins-slave-sg"
  description = "Allow web/SSH access to Jenkins Slave from Bastion"
  vpc_id      = var.vpc_id

  # Inbound rule To Allow SSH access (port 22) only from the bastion security group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# NodeJS Application Security Group ( Same EC2 of the Jenkins Slave Machine )
resource "aws_security_group" "app_sg" {
  name        = "${var.prefix}-app-sg"
  description = "App EC2 SG"
  vpc_id = var.vpc_id

  # Allow http traffic from ALB only
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]  
    description     = "Allow HTTP traffic from the internet"
    }
  
  # SSH from Jenkins Slave SG
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.slave_sg.id]
    description     = "Allow SSH from Jenkins Slave"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ALB Security Group – allows HTTP from the internet
resource "aws_security_group" "alb_sg" {
  name        = "${var.prefix}-alb-sg"
  description = "Allow HTTP to ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}