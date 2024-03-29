terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "cc-devops-26"
}
