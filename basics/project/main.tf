terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}


resource "aws_s3_bucket" "sparrow_s3" {
  bucket = "sparrow111"
}

resource "aws_s3_bucket_notification" "sparrow_sqs_notification" {
  bucket = aws_s3_bucket.sparrow_s3.id
  
  queue {
    queue_arn = aws_sqs_queue.sparrow_sqs.arn
    events = [ "s3:ObjectCreated:*" ]
    filter_suffix = "*.zip"
  }
}

resource "aws_sqs_queue" "sparrow_sqs" {
  name = "sparrow_s3_events_queue"
  policy = <<POLICY
  {
      "Version" : "2012-10-17",
      "Statement" : [
        {
            "Effect" : "Allow",
            "Principal" : "*",
            "Action" : "sqs:SendMessage",
            "Resource" : "arn:aws:sqs:*:*:sparrow_s3_events_queue"
        }
      ]
  }
  POLICY
}