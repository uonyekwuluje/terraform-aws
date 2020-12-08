resource "aws_internet_gateway" "devlab-vpc-gw" {
    vpc_id = aws_vpc.devlab-vpc.id
    tags = {
        Name = "${var.project_suffix}-vpc-gw"
    }
}

resource "aws_route_table" "devlab-vpc-public" {
    vpc_id = aws_vpc.devlab-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.devlab-vpc-gw.id
    }

    tags = {
        Name = "${var.project_suffix}-vpc-public-1"
    }
}

resource "aws_route_table_association" "devlab-vpc-public-1-a" {
    subnet_id = aws_subnet.devlab-vpc-public-1.id
    route_table_id = aws_route_table.devlab-vpc-public.id
}

resource "aws_route_table_association" "devlab-vpc-public-2-a" {
    subnet_id = aws_subnet.devlab-vpc-public-2.id
    route_table_id = aws_route_table.devlab-vpc-public.id
}
