variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of private subnets for RDS"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "mysql_username" {
  description = "MySQL master username"
  type        = string
  sensitive   = true
}

variable "mysql_password" {
  description = "MySQL master password"
  type        = string
  sensitive   = true
}

variable "postgres_username" {
  description = "PostgreSQL master username"
  type        = string
  sensitive   = true
}

variable "postgres_password" {
  description = "PostgreSQL master password"
  type        = string
  sensitive   = true
}