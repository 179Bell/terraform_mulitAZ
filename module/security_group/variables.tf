variable "vpc_id" {
    type = string
}

variable "public_subnet_id" {
    type = list(string)
}

variable "private_subnet_id" {
    type = list(string)
}

variable "name" {
    type = string
}