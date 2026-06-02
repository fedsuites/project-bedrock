# Developer IAM User
resource "aws_iam_user" "dev_view" {
  name = "bedrock-dev-view"

  tags = {
    Name = "bedrock-dev-view"
  }
}

# Console access
resource "aws_iam_user_login_profile" "dev_view" {
  user                    = aws_iam_user.dev_view.name
  password_reset_required = false
}

# Access keys for CLI
resource "aws_iam_access_key" "dev_view" {
  user = aws_iam_user.dev_view.name
}

# Attach ReadOnlyAccess policy
resource "aws_iam_user_policy_attachment" "dev_view_readonly" {
  user       = aws_iam_user.dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# S3 PutObject policy for assets bucket
resource "aws_iam_user_policy" "dev_view_s3" {
  name = "bedrock-dev-view-s3-policy"
  user = aws_iam_user.dev_view.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3PutObject"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          var.assets_bucket_arn,
          "${var.assets_bucket_arn}/*"
        ]
      }
    ]
  })
}