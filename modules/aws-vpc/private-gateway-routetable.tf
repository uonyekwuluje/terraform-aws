resource "aws_eip" "devlab-vpc-nat" {
   vpc      = true
}

resource "aws_nat_gateway" "devlab-vpc-nat-gw" {
  allocation_id = aws_eip.devlab-vpc-nat.id
  subnet_id = aws_subnet.devlab-vpc-public-1.id
  depends_on = [aws_internet_gateway.devlab-vpc-gw]
}


resource "aws_route_table" "devlab-vpc-private" {
    vpc_id = aws_vpc.devlab-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.devlab-vpc-nat-gw.id
    }

    tags = {
        Name = "${var.project_suffix}-vpc-private-1"
    }
}

resource "aws_route_table_association" "devlab-vpc-private-1-a" {
    subnet_id = aws_subnet.devlab-vpc-private-1.id
    route_table_id = aws_route_table.devlab-vpc-private.id
}

resource "aws_route_table_association" "devlab-vpc-private-2-a" {
    subnet_id = aws_subnet.devlab-vpc-private-2.id
    route_table_id = aws_route_table.devlab-vpc-private.id
}
