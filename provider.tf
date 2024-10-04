terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.69.0"
    }
  }
  backend "s3" {
    encrypt = false
    bucket = "bulzertfstatesto"
    key = "app/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "bulzartfstatelock"
  }
}

provider "aws" {
  region = local.region
}