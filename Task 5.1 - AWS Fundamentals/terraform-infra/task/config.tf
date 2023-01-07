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

terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.73"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "vishnevskiyav.terraform"
    key    = "task_5.1/terraform-infra/terraform.tfstate"
    region = "eu-central-1"
  }
}

