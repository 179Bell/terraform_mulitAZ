# data "template_file" "install_apache" {
#     template = file("user_data/install_apache.tpl")
# }

resource "aws_key_pair" "ec2_key" {
    key_name = "${var.name}-${terraform.workspace}"
    public_key = file("~/.ssh/ec2_${terraform.workspace}.pub")
}

module "ec2_1" {
    source = "../module/ec2"

    ami                           = var.ami
    name                          = "${var.name}-${terraform.workspace}-1"
    subnet_id                     = module.network.private_subnet[0].id
    security_groups               = module.security_group.ec2_sg
    instance_type                 = var.instance_type
    association_public_ip_address = false
    user_data                     = file("user_data/install_apache.tpl")
    key_name                      = aws_key_pair.ec2_key.key_name

    tags = {
        Name       = "${var.name}-${terraform.workspace}-1"
        ManagedBy  = "Terraform"
        Enviroment = terraform.workspace
    }
}

module "ec2_2" {
    source = "../module/ec2"

    ami                           = var.ami
    name                          = "${var.name}-${terraform.workspace}-2"
    subnet_id                     = module.network.private_subnet[1].id
    security_groups               = module.security_group.ec2_sg
    instance_type                 = var.instance_type
    association_public_ip_address = false
    user_data                     = file("user_data/install_apache.tpl")
    key_name                      = aws_key_pair.ec2_key.key_name

    tags = {
        Name       = "${var.name}-${terraform.workspace}-2"
        ManagedBy = "Terraform"
        Enviroment = terraform.workspace
    }
}