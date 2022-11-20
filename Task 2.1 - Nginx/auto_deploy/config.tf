# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Configuration file for terraform
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      version = ">= 0.12"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region                   = "eu-central-1"
  shared_credentials_files = ["C:/Users/Admin/.aws/credentials"]
  profile                  = "Aleksandr"
}
