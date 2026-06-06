# Project Bedrock — AltSchool Cloud Engineering Capstone

## Overview
Production-grade microservices deployment on AWS EKS for InnovateMart Inc.

**Student ID:** ALT/SOE/025/4616  
**AWS Account:** 445567073243  
**Region:** us-east-1

## Architecture
- VPC: `project-bedrock-vpc` with public/private subnets across 2 AZs
- EKS Cluster: `project-bedrock-cluster` (v1.34)
- RDS MySQL + PostgreSQL (private subnets)
- DynamoDB table
- S3 bucket + Lambda (event-driven)
- AWS Load Balancer Controller + ALB Ingress
- CloudWatch observability

## Live URLs
- **Retail Store App:** http://k8s-retailap-retailap-3c6aa53d7a-1183998592.us-east-1.elb.amazonaws.com

## How to Trigger the Pipeline
1. Push to `main` branch → triggers `terraform apply`
2. Open a Pull Request → triggers `terraform plan` (plan posted as PR comment)

## Bring Infrastructure Back Up
If infrastructure is scaled down, run:
```bash
aws eks update-nodegroup-config \
  --cluster-name project-bedrock-cluster \
  --nodegroup-name project-bedrock-node-group \
  --scaling-config minSize=2,maxSize=4,desiredSize=3 \
  --region us-east-1

aws rds start-db-instance --db-instance-identifier project-bedrock-mysql --region us-east-1
aws rds start-db-instance --db-instance-identifier project-bedrock-postgres --region us-east-1
```

## Grading Credentials
See submitted Google Doc for:
- `bedrock-dev-view` Access Key ID + Secret Access Key
- Console login credentials
- AWS Console URL: https://445567073243.signin.aws.amazon.com/console

## Terraform Outputs
Run `terraform output` or see `grading.json` in repo root.

## Repository Structure
project-bedrock/
├── .github/workflows/    # CI/CD pipeline
├── terraform/            # Infrastructure as Code
│   ├── modules/
│   │   ├── vpc/
│   │   ├── eks/
│   │   ├── rds/
│   │   ├── dynamodb/
│   │   ├── s3/
│   │   ├── lambda/
│   │   └── iam/
├── k8s/retail-app/       # Kubernetes manifests
├── lambda/               # Lambda function code
└── grading.json          # Terraform outputs for grading
