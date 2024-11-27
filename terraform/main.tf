module "vpc" {
  source               = "./modules/vpc"
  aws_region           = var.aws_region
  environment_name     = var.environment_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  role_arn        = data.aws_iam_role.labrole-arn.arn

  authentication_mode = "API"

  # Conexion a la red
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  node_role_arn = data.aws_iam_role.labrole-arn.arn

  eks_managed_node_groups = {
    default_group = {
      desired_capacity = 3
      max_size         = 3
      min_size         = 3
      ami_type         = "AL2023_x86_64_STANDARD"
    }
  }

  #  additional_tags = {
  #    Environment = "dev"
  #  }
}

module "ecr" {
  source = "./modules/ecr"

  ecr_repositories_names = var.applications
}


module "docker_build_push" {
  source = "./modules/docker"

  applications = var.applications
  registry_url = module.ecr.registry_url
  commit_short_sha = var.commit_short_sha  
}

