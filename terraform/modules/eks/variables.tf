variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of private subnets for EKS nodes"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "IDs of public subnets"
  type        = list(string)
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
}

variable "eks_node_instance_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
}

variable "eks_node_min_size" {
  description = "Minimum number of EKS nodes"
  type        = number
}

variable "eks_node_max_size" {
  description = "Maximum number of EKS nodes"
  type        = number
}

variable "eks_node_desired_size" {
  description = "Desired number of EKS nodes"
  type        = number
}

variable "eks_nodes_security_group_id" {
  description = "Security group ID for EKS nodes"
  type        = string
}