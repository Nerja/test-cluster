terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    external = {
      source = "hashicorp/external"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    random = {
      source = "hashicorp/random"
    }
    vault = {
      source = "hashicorp/vault"
    }
    github = {
      source = "integrations/github"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
    }
    flux = {
      source  = "fluxcd/flux"
    }
  }
  required_version = ">= 0.13"
}
