# AWS Infrastructure Labs
This is a collection of AWS Modules for use cases in AWS. Ensure you have you access and secret key before you begin
```
export AWS_ACCESS_KEY_ID="XMI"
export AWS_SECRET_ACCESS_KEY="GbMWBwiBb"
export AWS_DEFAULT_REGION="us-east-1"
```

## Terraform Operations
The following can be used to validate, test, create and destroy your stack
```
export TF_LOG=""
export TF_LOG_PATH=""
export TF_WARN_OUTPUT_ERRORS=1

rm -Rf .terraform
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
terraform state pull
```

## Kubernetes
Get EKS Credentials:
```
aws eks --region us-east-1 update-kubeconfig --name uchdevk8cluster
```
Test Kubectl:
```
kubectl get nodes

NAME                        STATUS   ROLES    AGE   VERSION
ip-10-0-2-35.ec2.internal   Ready    <none>   10m   v1.17.11-eks-cfdc40
ip-10-0-3-51.ec2.internal   Ready    <none>   10m   v1.17.11-eks-cfdc40
```
