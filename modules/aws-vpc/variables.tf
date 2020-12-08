variable "AWS_REGION" {    
    default = "us-east-1"
}

variable "project_suffix" {}
variable "network_name" {}
variable "environment" {}
variable "network_cidr" {} 
variable "network_public_cidr_1" {}
variable "network_public_cidr_2" {}
variable "network_private_cidr_1" {}
variable "network_private_cidr_2" {}
variable "aws_bastion_ami" {}
variable "aws_bastion_type" {}
