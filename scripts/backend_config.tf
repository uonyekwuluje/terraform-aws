terraform {
  backend "s3" {
    bucket         = "devenvlabs-terraform-tfstate"
    key            = "terraform/dev/terraform_dev.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devenvlabs_terraform_locks"
  }
}
