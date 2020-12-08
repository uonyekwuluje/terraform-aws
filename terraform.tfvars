project_suffix = "uchawslabs"
environment = "devenv"
network_name = "dev-network"
network_cidr = "10.0.0.0/16"
network_public_cidr_1 = "10.0.0.0/24"
network_public_cidr_2 = "10.0.1.0/24"
network_private_cidr_1 = "10.0.2.0/24"
network_private_cidr_2 = "10.0.3.0/24"

allpurpose_vm_size = {
  vm_1_by_2   = "t2.small"
  vm_2_by_4   = "t2.medium"
  vm_2_by_8   = "m5.large"
  vm_4_by_8   = "a1.xlarge"
  vm_4_by_16  = "m5.xlarge"
  vm_8_by_32  = "m5.2xlarge"
}
