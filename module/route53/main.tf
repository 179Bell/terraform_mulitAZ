resource "aws_route53_zone" "host_zone" {
    name = var.domain_name
}

resource "aws_route53_record" "ns" {
    zone_id         = aws_route53_zone.host_zone.id
    name            = var.domain_name
    type            = "NS"
    ttl             = var.ttl
    records         = aws_route53_zone.host_zone.name_servers
    allow_overwrite = var.allow_overwrite
}

# resource "aws_route53_record" "a" {
#     zone_id         = aws_route53_zone.host_zone.id
#     name            = var.domain_name
#     type            = "A"

#     alias {
#         name                   = var.name
#         zone_id                = var.zone_id
#         evaluate_target_health = var.evaluate_target_health
#     }
# }

resource "aws_acm_certificate" "cert" {
    domain_name               = "*.${var.domain_name}"
    subject_alternative_names = [var.domain_name]
    validation_method         = var.validation_method

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "${var.name}-acm"
    }
}

resource "aws_route53_record" "cert_validation" {
    for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
        name   = dvo.resource_record_name
        record = dvo.resource_record_value
        type   = dvo.resource_record_type
    }
    }

    allow_overwrite = var.allow_overwrite
    name            = each.value.name
    records         = [each.value.record]
    type            = each.value.type
    ttl             = "300"
    zone_id         = aws_route53_zone.host_zone.zone_id
}

resource "aws_acm_certificate_validation" "cert" {
    certificate_arn = aws_acm_certificate.cert.arn
    validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}