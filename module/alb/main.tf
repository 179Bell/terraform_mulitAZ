resource "aws_lb" "alb" {
    name               = "${var.name}-alb"
    internal           = var.internal
    load_balancer_type = var.lb_type
    security_groups    = [var.security_groups]
    subnets            = var.public_subnet_id

    tags = {
        "Name" = "${var.name}-alb"
    }
}

resource "aws_alb_target_group" "target" {
    name     = "${var.name}-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id

    health_check {
        interval            = 30
        path                = "/"
        port                = 80
        protocol             = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
        matcher             = 200
    }
}

resource "aws_alb_target_group_attachment" "alb" {
    count            = length(var.instance_id)
    target_group_arn = element(aws_alb_target_group.target.*.arn, count.index)
    target_id        = element(var.instance_id, count.index)
    port             = 80
}

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.alb.arn
    port              = var.https_listener
    protocol          = var.https_listern_protocol
    ssl_policy        = var.ssl_policy
    certificate_arn   = var.cert_arn

    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/html"
            status_code  = "403"
        }
    }
}

