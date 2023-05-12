terraform {
  backend "s3" {
    bucket         = "opsmx-terraform-state"
    key            = "terraform-aws-eks-workshop.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}
