module "security_group" {
    source = "../module/security_group"

    vpc_id            = module.network.vpc
    public_subnet_id  = module.network.public_subnet[*].id
    private_subnet_id = module.network.private_subnet[*].id
    name              = "${var.name}-${terraform.workspace}"
}