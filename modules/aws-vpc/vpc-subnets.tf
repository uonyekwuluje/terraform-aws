resource "aws_vpc" "devlab-vpc" {
    cidr_block = var.network_cidr
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
}

resource "aws_subnet" "devlab-vpc-public-1" {
    vpc_id = aws_vpc.devlab-vpc.id
    cidr_block = var.network_public_cidr_1
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags = {
        Name = "${var.project_suffix}-vpc-public-1"
    }
}

resource "aws_subnet" "devlab-vpc-public-2" {
    vpc_id = aws_vpc.devlab-vpc.id
    cidr_block = var.network_public_cidr_2
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags = {
        Name = "${var.project_suffix}-vpc-public-2"
    }
}

resource "aws_subnet" "devlab-vpc-private-1" {
    vpc_id = aws_vpc.devlab-vpc.id
    cidr_block = var.network_private_cidr_1
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags = {
        Name = "${var.project_suffix}-vpc-private-1"
    }
}

resource "aws_subnet" "devlab-vpc-private-2" {
    vpc_id = aws_vpc.devlab-vpc.id
    cidr_block = var.network_private_cidr_2
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags = {
        Name = "${var.project_suffix}-vpc-private-2"
    }
}


output "public_subnet_one_id" {
  value = aws_subnet.devlab-vpc-public-1.id
}

output "public_subnet_two_id" {
  value = aws_subnet.devlab-vpc-public-2.id
}

output "private_subnet_one_id" {
  value = aws_subnet.devlab-vpc-private-1.id
}

output "private_subnet_two_id" {
  value = aws_subnet.devlab-vpc-private-2.id
}

output "vpc_id" {
  value = aws_vpc.devlab-vpc.id
}
