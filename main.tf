provider "aws" {
  region = "eu-north-1"
}

module "main_vpc" {
  source                    = "./modules/vpc"
  vpc_name                  = "main-vpc"
  cidr_block                = "192.168.0.0/16"
  availability_zones        = ["eu-north-1a", "eu-north-1b"]
  public_subnet_cidrs       = ["192.168.0.0/24", "192.168.1.0/24"]
  private_subnet_cidrs      = ["192.168.2.0/24", "192.168.3.0/24"]
  private_data_subnet_cidrs = ["192.168.4.0/24", "192.168.5.0/24"]
}

module "security_group" {
  source              = "./modules/security_group"
  vpc_id              = module.main_vpc.vpc_id
  security_group_name = "ec2-sg"
  depends_on          = [module.main_vpc]
}

module "security_group_alb" {
  source     = "./modules/security_group_alb"
  vpc_id     = module.main_vpc.vpc_id
  depends_on = [module.main_vpc]
}

module "loadbalancing" {
  source            = "./modules/alb"
  alb_name          = "application-load-balancer"
  vpc_id            = module.main_vpc.vpc_id
  subnet_ids        = module.main_vpc.public_subnet_ids
  security_group_id = [module.security_group_alb.asg_security_group_id]
  depends_on        = [module.main_vpc, module.security_group_alb]
}

module "compute" {
  source             = "./modules/ec2"
  subnet_ids         = module.main_vpc.private_subnet_ec2_ids
  security_group_ids = [module.security_group_alb.asg_security_group_id]
  key_name           = "server-key"
  target_group_arns  = [module.loadbalancing.target_group_arn]
  depends_on         = [module.main_vpc, module.loadbalancing, module.security_group_alb]
}

module "scaling" {
  source     = "./modules/scaling"
  asg_name   = module.compute.asg_name
  depends_on = [module.compute]
}


