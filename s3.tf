resource "aws_s3_bucket" "aws_project_2" {
  bucket = var.bucket_name

  tags = {
    Name        = "aws_project_2"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_versioning" "aws_project_2" {
  bucket = aws_s3_bucket.aws_project_2.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_public_access_block" "aws_project_2" {
  bucket = aws_s3_bucket.aws_project_2.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_server_side_encryption_configuration" "aws_project_2" {
  bucket = aws_s3_bucket.aws_project_2.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.aws_project_2.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.aws_project_2.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "aws_project_2" {
  bucket = aws_s3_bucket.aws_project_2.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
