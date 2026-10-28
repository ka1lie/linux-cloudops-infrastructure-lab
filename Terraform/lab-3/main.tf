module "network" {
    source = "./modules/network"
    environment = var.environment
}

module "compute" {
    source = "./modules/compute"
    aws_region = var.aws_region
    environment = var.environment
    subnet_public_id = module.network.subnet_public_id
    subnet_private_id = module.network.subnet_private_id
    vpc_id = module.network.vpc_id
    igw_id = module.network.igw_id
    sg_id = module.network.sg_id
}