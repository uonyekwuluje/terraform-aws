resource "aws_security_group" "sg_22" {
  name = "sg_22"
  vpc_id = aws_vpc.devlab-vpc.id

  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  tags = {
    Environment = var.environment
  }
}

resource "aws_instance" "bastion_instance" {
  ami                    = var.aws_bastion_ami
  instance_type          = var.aws_bastion_type
  subnet_id              = aws_subnet.devlab-vpc-public-1.id
  vpc_security_group_ids = [aws_security_group.sg_22.id]
  key_name               = "deploy-key" 

  tags = {
    Environment = var.environment
    Name = "bastion"
 }
}


output "bastion_ip" {
  value = aws_instance.bastion_instance.public_dns
}
