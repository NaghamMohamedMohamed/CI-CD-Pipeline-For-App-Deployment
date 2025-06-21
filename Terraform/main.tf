# Network Module
module "network" {
  source   = "./modules/network"
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets
  prefix   = var.prefix
  region   = var.region
}

# Security Groups Module
module "security-groups" {
  source = "./modules/security-groups"
  vpc_id = module.network.vpc_id
  prefix   = var.prefix

}

# EC2 Module
module "ec2" {
  source = "./modules/ec2"
  prefix   = var.prefix
  instance_type   = var.instance_type

  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids

  key_name        = var.key_name
  public_key_path = var.public_key_path
  
  bastion_sg_id = module.security-groups.bastion_sg
  jenkins_master_sg_id = module.security-groups.master_sg
  jenkins_slave_sg_id    = module.security-groups.slave_sg
  app_sg_id = module.security-groups.app_sg
}

# Application Load Balancer ModuleApplication
module "alb" {
  source = "./modules/alb"
  prefix   = var.prefix

  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  alb_sg_id          = module.security-groups.alb_sg
  target_instance_id = module.ec2.jenkins_slave_instance_id
}
