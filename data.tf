data "aws_s3_bucket" "aws_project_2" {
  bucket = "aws-project2-yt"
}

data "aws_acm_certificate" "aws_project_2" {
  domain      = "devops-yvesb.cf"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}