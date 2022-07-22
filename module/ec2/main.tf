resource "aws_instance" "this" {

    ami                         = var.ami
    instance_type               = var.instance_type
    vpc_security_group_ids      = [var.security_groups]
    subnet_id                   = var.subnet_id
    associate_public_ip_address = var.association_public_ip_address
    key_name                    = var.key_name
    iam_instance_profile        = aws_iam_instance_profile.ssm_role.name
    user_data                   = var.user_data

    tags                        = var.tags
}

# ##########################
# # EC2 IAM Role
# ##########################
data "aws_iam_policy_document" "ssm_role" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers =["ec2.amazonaws.com"]
        }
    }
}

resource "aws_iam_instance_profile" "ssm_role" {
    name = "EC2roleforSSM"
    role = aws_iam_role.ssm_role.name
}

resource "aws_iam_role" "ssm_role" {
    name = "EC2RoleformSSM"
    assume_role_policy = data.aws_iam_policy_document.ssm_role.json
}

resource "aws_iam_role_policy_attachment" "ssm_role" {
    role = aws_iam_role.ssm_role.name
    policy_arn = "arn:aws:iam:aws:policy/AmazonSSMManagedInstanceCore"
}