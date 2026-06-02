# RDS Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

# MySQL RDS Instance
resource "aws_db_instance" "mysql" {
  identifier        = "${var.project_name}-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.rds_instance_class
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "retailstore"
  username = var.mysql_username
  password = var.mysql_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_security_group_id]

  skip_final_snapshot     = true
  backup_retention_period = 0
  multi_az                = false
  publicly_accessible     = false
  deletion_protection     = false

  tags = {
    Name = "${var.project_name}-mysql"
  }
}

# PostgreSQL RDS Instance
resource "aws_db_instance" "postgres" {
  identifier        = "${var.project_name}-postgres"
  engine            = "postgres"
  engine_version    = "15.8"
  instance_class    = var.rds_instance_class
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "retailstore"
  username = var.postgres_username
  password = var.postgres_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_security_group_id]

  skip_final_snapshot     = true
  backup_retention_period = 0
  multi_az                = false
  publicly_accessible     = false
  deletion_protection     = false

  tags = {
    Name = "${var.project_name}-postgres"
  }
}

# Store MySQL credentials in Secrets Manager
resource "aws_secretsmanager_secret" "mysql" {
  name                    = "${var.project_name}/mysql-credentials"
  recovery_window_in_days = 0

  tags = {
    Name = "${var.project_name}-mysql-secret"
  }
}

resource "aws_secretsmanager_secret_version" "mysql" {
  secret_id = aws_secretsmanager_secret.mysql.id
  secret_string = jsonencode({
    username = var.mysql_username
    password = var.mysql_password
    host     = aws_db_instance.mysql.address
    port     = 3306
    dbname   = "retailstore"
  })
}

# Store PostgreSQL credentials in Secrets Manager
resource "aws_secretsmanager_secret" "postgres" {
  name                    = "${var.project_name}/postgres-credentials"
  recovery_window_in_days = 0

  tags = {
    Name = "${var.project_name}-postgres-secret"
  }
}

resource "aws_secretsmanager_secret_version" "postgres" {
  secret_id = aws_secretsmanager_secret.postgres.id
  secret_string = jsonencode({
    username = var.postgres_username
    password = var.postgres_password
    host     = aws_db_instance.postgres.address
    port     = 5432
    dbname   = "retailstore"
  })
}