variable "name" {
    type = string

    default = "bell"
}

variable "vpc_cidr" {
    type = map(string)

    default = {
        "prod" = "10.0.0.0/16"
        "dev"  = "10.10.0.0/16"
    }
}

variable "public_subnet_cidr" {
    type = map(list(string))

    default = {
        "prod" = ["10.0.1.0/24", "10.0.3.0/24"]
        "dev"  = ["10.10.1.0/24", "10.10.3.0/24"]
    }
}

variable "private_subnet_cidr" {
    type = map(list(string))

    default = {
        "prod" = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24", "10.0.10.0/24"]
        "dev"  = ["10.10.2.0/24", "10.10.4.0/24", "10.10.6.0/24", "10.10.10.0/24"]
    }
}

variable "az" {
    type = list(string)

    default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

variable "ami" {
    type = string
}

variable "instance_type" {
    type    = string
    default = "t3.micro"
}