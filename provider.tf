https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started


terraform {

  required_providers {

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version= "4.16.0"
    }

  }
  backend "s3" {
   bucket = "terraform-c32"
   key = "states/terraform.tfstate"
   region = "us-east-1"
}
}

provider "aws" {
   region = "us-east-1"

}


 CIDR is mandatory on vpc 



sudo rm -r .terraform

we need terraform init cmd-
whenever adding new provider,new module and changing on backend configuration


jenkins-private mach
bastion-public mach
ec2 mach-public mach

  bucket = "my_s3_bucket"

  acl    = private

}
