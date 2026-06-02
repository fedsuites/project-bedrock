# Required outputs for grading script
output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "assets_bucket_name" {
  description = "Assets S3 bucket name"
  value       = module.s3.bucket_name
}

# Additional useful outputs
output "mysql_endpoint" {
  description = "MySQL RDS endpoint"
  value       = module.rds.mysql_endpoint
}

output "postgres_endpoint" {
  description = "PostgreSQL RDS endpoint"
  value       = module.rds.postgres_endpoint
}

output "dev_view_access_key_id" {
  description = "Developer IAM access key ID"
  value       = module.iam.dev_view_access_key_id
}

output "dev_view_secret_access_key" {
  description = "Developer IAM secret access key"
  value       = module.iam.dev_view_secret_access_key
  sensitive   = true
}

output "dev_view_password" {
  description = "Developer IAM console password"
  value       = module.iam.dev_view_password
  sensitive   = true
}