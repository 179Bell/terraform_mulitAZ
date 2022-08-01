module "alb" {
  source = "../module/alb"

  name             = "${var.name}-${terraform.workspace}"
  public_subnet_id = module.network.public_subnet[*].id
  security_groups  = module.security_group.alb_sg
  cert_arn         = module.route53.cert_arn
  vpc_id           = module.network.vpc
  instance_id      = [module.ec2_1.instance_id, module.ec2_2.instance_id]
}