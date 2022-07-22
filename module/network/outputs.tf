output "vpc" {
    value = aws_vpc.this.id
}

output "public_subnet" {
    value = aws_subnet.public
}

output "private_subnet" {
    value = aws_subnet.private
}