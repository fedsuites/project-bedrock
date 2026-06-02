# State backend resources - created manually before terraform init
# aws s3 mb s3://project-bedrock-state-445567073243 --region us-east-1
# aws dynamodb create-table --table-name project-bedrock-state-lock \
#   --attribute-definitions AttributeName=LockID,AttributeType=S \
#   --key-schema AttributeName=LockID,KeyType=HASH \
#   --billing-mode PAY_PER_REQUEST --region us-east-1

module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  aws_region           = var.aws_region
}

module "eks" {
  source = "./modules/eks"

  project_name                = var.project_name
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  private_subnet_ids          = module.vpc.private_subnet_ids
  public_subnet_ids           = module.vpc.public_subnet_ids
  eks_cluster_version         = var.eks_cluster_version
  eks_node_instance_type      = var.eks_node_instance_type
  eks_node_min_size           = var.eks_node_min_size
  eks_node_max_size           = var.eks_node_max_size
  eks_node_desired_size       = var.eks_node_desired_size
  eks_nodes_security_group_id = module.vpc.eks_nodes_security_group_id
}

module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  environment           = var.environment
  private_subnet_ids    = module.vpc.private_subnet_ids
  rds_security_group_id = module.vpc.rds_security_group_id
  rds_instance_class    = var.rds_instance_class
  mysql_username        = var.rds_mysql_username
  mysql_password        = var.rds_mysql_password
  postgres_username     = var.rds_postgres_username
  postgres_password     = var.rds_postgres_password
}

module "dynamodb" {
  source = "./modules/dynamodb"

  project_name = var.project_name
  environment  = var.environment
}

module "lambda" {
  source = "./modules/lambda"

  project_name = var.project_name
  environment  = var.environment
}

module "s3" {
  source = "./modules/s3"

  project_name        = var.project_name
  student_id          = var.student_id
  lambda_function_arn = module.lambda.function_arn
}

module "iam" {
  source = "./modules/iam"

  project_name      = var.project_name
  assets_bucket_arn = module.s3.bucket_arn
  eks_cluster_name  = module.eks.cluster_name
}