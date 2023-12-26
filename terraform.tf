terraform {
  backend "s3" {
    bucket = "dev-private-hcl-v1"
    key    = "main.tfstate"
    region = "ap-south-1"
  }
}
