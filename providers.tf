terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.30.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAYDAXJJRSVI57YADR"
  secret_key = "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"

}