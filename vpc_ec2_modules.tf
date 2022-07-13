module "vpc" {
  source= "teraform-aws-modules/vpc/aws"

   name= "my-vpc-module"
   cidr= "10.0.0.0/16"

  azs=      ["us-east-1a", "us-east-1c"]
 private_subnets= ["10.0.1.0.24" , "10.0.3.0/24"]
 public_subnets= ["10.0.101.0/24" , "10.0.103.0/24"]

 enable_nat_gateway = true
 enable_vpn_gateway = true

tags= {
   Terraform = "true"
   Environment = "dev"
   Company=  "upgrad"

}
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "bashion-instance"

  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  key_name               = "bashion-login"
  monitoring             = true
  vpc_security_group_ids = ["sg-05127b7a82dab5b65"]
  subnet_id              = "subnet-038c4c482b1658de2"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins-instance"

  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  key_name               = "bashion-login"
  monitoring             = true
  vpc_security_group_ids = ["sg-0a55c1aeee7f2e9e7"]
  subnet_id              = "subnet-0e881ab379df7042c"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "application-instance"

  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  key_name               = "bashion-login"
  monitoring             = true
  vpc_security_group_ids = ["sg-03b8da1a31d0e35d4"]
  subnet_id              = "subnet-07683b0e0b8df5166"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
