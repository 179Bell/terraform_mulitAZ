variable "name" {
    type = string
}

variable "public_subnet_id" {
    type = list(string)
}

variable "lb_type" {
    type    = string
    default = "application"
}

variable "internal" {
    type    = bool
    default = false
}

variable "security_groups" {
    type = string
}

variable "https_listener_port" {
    type    = string
    default = "443"
}

variable "https_listern_protocol" {
    type    = string
    default = "HTTPS"
}

variable "ssl_policy" {
    type    = string
    default = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
}

variable "cert_arn" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "instance_id" {
    type = list(string)
}

variable "https_listener" {
    type = string
    default = "443"
}