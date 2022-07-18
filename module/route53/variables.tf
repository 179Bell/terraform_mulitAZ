variable "name" {
    type = string
}

variable "domain_name" {
    type = string
}

variable "private_zone" {
    type = bool
    default = false
}

variable "ttl" {
    type = string
    default = "30"
}

variable "allow_overwrite" {
    type = bool
    default = true
}

variable "evaluate_target_health" {
    type = bool
    default = true
}

variable "validation_method" {
    type = string
    default = "DNS"
}

variable "create_before_destroy" {
    type = bool
    default = true
}