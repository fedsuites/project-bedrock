variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "project-bedrock"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "student_id" {
  description = "AltSchool student ID for unique resource naming"
  type        = string
  default     = "altsoee0254616"
}

# VPC
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# EKS
variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.34"
}

variable "eks_node_instance_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
  default     = "t3.small"
}

variable "eks_node_min_size" {
  description = "Minimum number of EKS nodes"
  type        = number
  default     = 2
}

variable "eks_node_max_size" {
  description = "Maximum number of EKS nodes"
  type        = number
  default     = 4
}

variable "eks_node_desired_size" {
  description = "Desired number of EKS nodes"
  type        = number
  default     = 3
}

# RDS
variable "rds_mysql_username" {
  description = "MySQL RDS master username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "rds_mysql_password" {
  description = "MySQL RDS master password"
  type        = string
  sensitive   = true
}

variable "rds_postgres_username" {
  description = "PostgreSQL RDS master username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "rds_postgres_password" {
  description = "PostgreSQL RDS master password"
  type        = string
  sensitive   = true
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
} 
 
