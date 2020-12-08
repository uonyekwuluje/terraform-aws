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

variable "aws_bastion_ami" {
  default = "ami-00068cd7555f543d5"
}

variable "aws_bastion_type" {
  default = "t2.micro"
}

variable "aws_centos7_base_ami" {
  default = "ami-0083662ba17882949"
}

variable "aws_centos8_base_ami" {
  default = "ami-00594b9c138e6303d"
}

variable "aws_rhel7_base_ami" {
  default = "ami-61479f1c"
}

variable "aws_ubuntu18_base_ami" {
  default = "ami-017531a4d58b5475e"
}

variable "allpurpose_vm_size" {}

variable "node_count" {
  default = "1"
}

variable "disk_size" {
  default = 50
}

variable "kubernetes_instance_type" {
  default = "m5.xlarge"
}

variable "kubernetes_version" {
  default = "1.17"
}

variable "kubernetes_desired_node_size" {
  default = 2
}

variable "kubernetes_desired_node_max_size" {
  default = 5
}

variable "kubernetes_desired_node_min_size" {
  default = 2
}

variable "kubernetes_node_disk_size" {
  default = 50
}
