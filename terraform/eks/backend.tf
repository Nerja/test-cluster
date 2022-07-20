terraform {
  backend "s3" {
    bucket   = "nerja-terraform"
    key      = "test-cluster/eks/terraform.tfstate"
    region   = "us-east-1"
    profile  = "marcusprivate"
  }
}