####################################
# vpc
####################################
resource "aws_vpc" "this" {
    cidr_block                       = var.vpc_cidr
    enable_dns_hostnames             = var.enable_dns_hostnames
    enable_dns_support               = var.enable_dns_support
    assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

    tags = {
        "Name" = "${var.name}-vpc"
    }
}
####################################
# internet gateway
####################################
resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
    tags = {
        "Name" = "${var.name}-igw"
    }
}
####################################
# public subnet
####################################
resource "aws_route_table" "public" {
    vpc_id                          = aws_vpc.this.id

    tags = {
        "Name" = "${var.name}-public-subnet-rt" 
    }
}

resource "aws_route_table_association" "public" {
    count          = length(var.public_subnet_cidr)
    subnet_id      = element(aws_subnet.public.*.id, count.index)
    route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_gateway" {
    route_table_id         = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.this.id
    
    timeouts {
        create = "5m"
    }
}

resource "aws_subnet" "public" {
    vpc_id                          = aws_vpc.this.id
    count                           = length(var.public_subnet_cidr)
    cidr_block                      = element(var.public_subnet_cidr, count.index)
    availability_zone               = element(var.az, count.index)
    map_public_ip_on_launch         = var.map_public_ip_on_launch
    assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

    tags = {
        "Name" = "${var.name}-public-subnet-${count.index+1}"
    }
}
####################################
# private subnet
####################################
resource "aws_route_table" "private" {
    vpc_id                          = aws_vpc.this.id

    tags = {
        "Name" = "${var.name}-private-subnet-rt" 
    }
}

resource "aws_route_table_association" "private" {
    count          = length(var.private_subnet_cidr)
    subnet_id      = element(aws_subnet.private.*.id, count.index)
    route_table_id = aws_route_table.private.id
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.this.id

    count                           = length(var.private_subnet_cidr)
    cidr_block                      = element(var.private_subnet_cidr, count.index)
    availability_zone               = element(var.az, count.index)

    tags = {
        "Name" = "${var.name}-private-subnet-${count.index+1}"
    }
}