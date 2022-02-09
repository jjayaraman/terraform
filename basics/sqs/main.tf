terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.74.1"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "default"
  region = var.region
}


resource "aws_sqs_queue" "jay_sqs" {
  name = "jaysqs"
}
