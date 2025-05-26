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

module "ec2_security_group" {
  source              = "./modules/security_group"
  vpc_id              = module.main_vpc.vpc_id
  security_group_name = "ec2-sg"
}

# module "ec2" {
#   source     = "./modules/compute"
#   subnet_ids = []
# }
