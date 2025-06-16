terraform {
  backend "s3" {
    bucket       = "lab02-terraform-state-group18"
    key          = "terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
  }
}
### Declare the VPC module
module "vpc_module" {
  source              = "./modules/vpc"
  region              = var.region
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}


### Declare the NAT Gateway module
module "nat_gateway_module" {
  source     = "./modules/nat-gateway"
  region     = var.region
  subnet_ids = module.vpc_module.public_subnet_id[0]
}

### Declare the Route table module
module "route_table_module" {
  source             = "./modules/route-tables"
  region             = var.region
  vpc_ids            = module.vpc_module.vpc_id
  igw_ids            = module.vpc_module.igw_id
  nat-gateway_ids    = module.nat_gateway_module.nat_gateway_id
  public_subnet_ids  = module.vpc_module.public_subnet_id[0]
  private_subnet_ids = module.vpc_module.private_subnet_id[0]
}

### Declare the Security Group module
module "security_group_module" {
  source     = "./modules/security-group"
  vpc_id     = module.vpc_module.vpc_id
  cidr_block = var.cidr_block
}

### Declare the EC2 module
module "ec2_module" {
  source = "./modules/ec2"
  region = var.region
  instances_configuration = [{
    count                  = var.instances_configuration[0].count
    ami                    = var.instances_configuration[0].ami
    instance_type          = var.instances_configuration[0].instance_type
    root_block_device      = var.instances_configuration[0].root_block_device
    tags                   = var.instances_configuration[0].tags
    vpc_security_group_ids = [module.security_group_module.public_ssh-sg_id]
    subnet_id              = module.vpc_module.public_subnet_id[0]
    user_data_file         = var.instances_configuration[0].user_data_file
    key_name               = var.instances_configuration[0].key_name
    associate_elastic_ip   = var.instances_configuration[0].associate_elastic_ip
    iam_instance_profile   = var.instances_configuration[0].iam_instance_profile
    },
    {
      count                  = var.instances_configuration[1].count
      ami                    = var.instances_configuration[1].ami
      instance_type          = var.instances_configuration[1].instance_type
      root_block_device      = var.instances_configuration[1].root_block_device
      tags                   = var.instances_configuration[1].tags
      vpc_security_group_ids = [module.security_group_module.private_ssh-sg_id]
      subnet_id              = module.vpc_module.private_subnet_id[0]
      user_data_file         = var.instances_configuration[1].user_data_file
      key_name               = var.instances_configuration[1].key_name
      associate_elastic_ip   = var.instances_configuration[1].associate_elastic_ip
      iam_instance_profile   = var.instances_configuration[1].iam_instance_profile
    }
  ]
}