module "route53" {
    source = "../module/route53"

    name      = "${var.name}-${terraform.workspace}"
    domain_name    = var.domain_name
}