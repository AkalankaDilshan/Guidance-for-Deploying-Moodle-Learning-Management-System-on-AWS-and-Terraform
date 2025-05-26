provider "aws" {
  region = ""
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
