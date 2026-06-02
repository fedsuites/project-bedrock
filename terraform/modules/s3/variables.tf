variable "project_name" {
  description = "Project name"
  type        = string
}

variable "student_id" {
  description = "Student ID for unique bucket naming"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to trigger"
  type        = string
}