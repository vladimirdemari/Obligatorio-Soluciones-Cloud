module "vpc" {
  source               = "./modules/vpc"
  aws_region           = var.aws_region
  environment_name     = var.environment_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}


