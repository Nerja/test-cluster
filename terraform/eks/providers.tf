provider "aws" {
    profile = "marcusprivate"
    region = "eu-west-1"
}

provider "flux" {}

provider "kubectl" {
  cluster_ca_certificate = base64decode(module.cluster.cluster_certificate_authority_data)
  host                   = module.cluster.cluster_endpoint
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws-iam-authenticator"
    args        = ["token", "-i", module.cluster.cluster_id]
    env = {
        AWS_PROFILE = "marcusprivate"
    }
  }
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(module.cluster.cluster_certificate_authority_data)
  host                   = module.cluster.cluster_endpoint

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws-iam-authenticator"
    args        = ["token", "-i", module.cluster.cluster_id]
    env = {
        AWS_PROFILE = "marcusprivate"
    }
  }
}

provider "github" {}