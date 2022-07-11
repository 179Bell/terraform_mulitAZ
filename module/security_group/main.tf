########################################
# alb security group
########################################
resource "aws_security_group" "alb_sg" {
    vpc_id = var.vpc_id
    name   = "alb_sg"

    ingress {
        description      = "TLS from Internet"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.name}-alb-sg"
    }
}
########################################
# ec2 security group
########################################
resource "aws_security_group" "ec2_sg" {
    vpc_id = var.vpc_id
    name   = "ec2_sg"

    ingress {
        description      = "From ALB to EC2"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        security_groups = [
            aws_security_group.alb_sg.id
        ]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.name}-ec2-sg"
    }
}
########################################
# vpcendpoint security group
########################################
resource "aws_security_group" "ssm" {
    name = "${var.name}-ssm-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [
            "10.0.0.0/16"
        ]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.name}-ssm-sg"
    }
}