######################################
#  SSH Key Pair Fpr The EC2 Instances
######################################

resource "aws_key_pair" "ec2_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

######################################
#        DATA SOURCE (AMI)
######################################

# Gets the most recent Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

######################################
#       EC2 INSTANCES
######################################

# Bastion Host in Public Subnet
resource "aws_instance" "bastion" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id = var.public_subnet_ids[0]
  key_name  = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [var.bastion_sg_id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.prefix}-bastion"
  }
}

# Jenkins Master Server in Private Subnet
resource "aws_instance" "jenkins_master" {
  ami  = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_ids[0]
  private_ip = var.master_private_ip
  key_name = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [var.jenkins_master_sg_id]
  tags = {
    Name = "${var.prefix}-jenkins-master"
  }
}

# Jenkins Slave Instance in Private Subnet ( Same as the one on which will the App be deployed )
resource "aws_instance" "jenkins_slave" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_ids[1]
  private_ip = var.slave_private_ip
  key_name  = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [
    var.jenkins_slave_sg_id,
    var.app_sg_id
  ]
  tags = {
    Name = "${var.prefix}-jenkins-slave"
  }
}