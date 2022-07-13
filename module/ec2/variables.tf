variable "ami" {
    type = string
}

variable "name" {
    type = string
}

variable "subnet_id" {
    type = list(string)
}

variable "security_groups" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "association_public_ip_address" {
    type = bool
}

variable "user_data" {
    type = string
}

variable "tags" {
    type = map(string)
}

variable "key_name" {
    type = string
}