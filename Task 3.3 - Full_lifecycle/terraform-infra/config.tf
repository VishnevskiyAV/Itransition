# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Configuration file for terraform
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region                   = "eu-central-1"
  shared_credentials_files = ["C:/Users/Admin/.aws/credentials"]
  profile                  = "Aleksandr"
}

# Remote state s3 Bucket
terraform {
  backend "s3" {
    bucket = "vishnevskiyav.terraform"
    key    = "terraform-infra/terraform.tfstate"
    region = "eu-central-1"
  }
}