terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.21.0"
    }
  }
  backend "s3" {
    bucket = "terraform-c32-yashwanth-project"
    key    = "terraformstate/"
    region = "us-east-1"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
