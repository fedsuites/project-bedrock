output "mysql_endpoint" {
  description = "MySQL RDS endpoint"
  value       = aws_db_instance.mysql.address
}

output "mysql_port" {
  description = "MySQL RDS port"
  value       = aws_db_instance.mysql.port
}

output "postgres_endpoint" {
  description = "PostgreSQL RDS endpoint"
  value       = aws_db_instance.postgres.address
}

output "postgres_port" {
  description = "PostgreSQL RDS port"
  value       = aws_db_instance.postgres.port
}

output "mysql_secret_arn" {
  description = "ARN of MySQL credentials secret"
  value       = aws_secretsmanager_secret.mysql.arn
}

output "postgres_secret_arn" {
  description = "ARN of PostgreSQL credentials secret"
  value       = aws_secretsmanager_secret.postgres.arn
}