module "network" {
    source = "../module/network"

    name                = "${var.name}-${terraform.workspace}"
    vpc_cidr            = var.vpc_cidr[terraform.workspace]
    public_subnet_cidr  = var.public_subnet_cidr[terraform.workspace]
    private_subnet_cidr = var.private_subnet_cidr[terraform.workspace]
    az                  = var.az
}