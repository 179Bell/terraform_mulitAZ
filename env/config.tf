provider "aws" {
    region = "us-east-1"
}

terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }
    }
    backend "s3" {
        bucket = "suzumura-remote-backend"
        key    = "terraform/terraform.tfstate"
        region = "us-east-1"
    }
}

