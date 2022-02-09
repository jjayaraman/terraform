terraform {
  required_providers {
    name = {
      source = "hashicorp/aws"
      version = "~>3.27"
     }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}



resource "aws_s3_bucket" "jays3" {
  bucket = "jayfirstbucket123"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET","PUT","POST"]
    allowed_origins = ["*"]
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id = "cleanup"
    enabled = true
    
    expiration {
      days = 1
    }
  }
}

resource "aws_s3_account_public_access_block" "jays3" {
  # restrict_public_buckets = false
  block_public_acls = true
  block_public_policy = true
  
}

output "s3" {
  value = aws_s3_bucket.jays3.arn
}