#!/bin/bash
TERRAFORM_INFRA_PREFFIX="devenvlabs"
TERRAFORM_S3_BUCKET="${TERRAFORM_INFRA_PREFFIX}-terraform-tfstate"
AWS_REGION="us-east-1"
DYNAMODB_TABLE_NAME="${TERRAFORM_INFRA_PREFFIX}_terraform_locks"
TERRAFORM_BACKEND_KEY="terraform/dev/terraform_dev.tfstate"

create_terraform_backend() {
# Create S3 bucket
aws s3api create-bucket  \
  --bucket ${TERRAFORM_S3_BUCKET}  \
  --region ${AWS_REGION} 

# Enable S3 Versioning
aws s3api put-bucket-versioning \
  --bucket ${TERRAFORM_S3_BUCKET} \
  --versioning-configuration Status=Enabled

# Create DynamoDB Lock Table
aws dynamodb create-table \
  --region "${AWS_REGION}" \
  --table-name "${DYNAMODB_TABLE_NAME}" \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 

cat <<EOF > ./backend_config.tf
terraform {
  backend "s3" {
    bucket         = "${TERRAFORM_S3_BUCKET}"
    key            = "${TERRAFORM_BACKEND_KEY}"
    region         = "${AWS_REGION}"
    dynamodb_table = "${DYNAMODB_TABLE_NAME}"
  }
}
EOF

cat ./backend_config.tf
}


#============== Main Menu ================
create_terraform_backend
