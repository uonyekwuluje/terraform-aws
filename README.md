# AWS Infrastructure Labs
This is a collection of AWS Modules for use cases in AWS


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
