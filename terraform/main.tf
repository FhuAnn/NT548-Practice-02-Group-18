module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.vpc.public_subnet_id
  sg_id = module.security_groups.ec2_sg
}