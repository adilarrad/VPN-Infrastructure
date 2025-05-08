terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc"{
    source = "./modules/vpc"
}

module "security-group"{
    source = "./modules/security-group"
    vpc-id = module.vpc.vpc-id
}

module "ec2"{
    source                = "./modules/ec2"
    subnet-id             = module.vpc.subnet-id
    instance-profile-name = module.iam.instance-profile-name
    sec-group             = module.security-group.sec-grp-id
}

module "s3"{
    source = "./modules/s3"
}

module "iam"{
    source               = "./modules/iam"
    ansible-bucket-arn   = module.s3.ansible-bucket-arn
    wireguard-bucket-arn = module.s3.wireguard-bucket-arn
}