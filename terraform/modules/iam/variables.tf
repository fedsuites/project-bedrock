variable "project_name" {
  description = "Project name"
  type        = string
}

variable "assets_bucket_arn" {
  description = "ARN of the assets S3 bucket"
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}