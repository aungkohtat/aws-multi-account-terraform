terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
  }
}

provider "aws" {
  alias   = "ygnadmin"
  profile = "ygn-admin"
  region  = "us-west-1"
}

provider "aws" {
  alias   = "mdyadmin"
  profile = "mdy-admin"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "mandalay"
  profile = "mdy-admin"
  region  = "us-east-1"
}