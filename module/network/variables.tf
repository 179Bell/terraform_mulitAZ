variable "name" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "public_subnet_cidr" {
    type = list(string)
}

variable "private_subnet_cidr" {
    type = list(string)
}

variable "enable_dns_hostnames" {
    type = bool
    default = true
}

variable "enable_dns_support" {
    type = bool
    default = true
}

variable "assign_generated_ipv6_cidr_block" {
    type = bool
    default = false
}

variable "az" {
    type = list(string)
}

variable "map_public_ip_on_launch" {
    type = bool
    default = true
}

variable "assign_ipv6_address_on_creation" {
    type = bool
    default = false
}