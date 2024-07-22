terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.4"
    }
  }
  # backend "s3" {
  #   bucket         = "aws-eks-cluster-state"
  #   key            = "techsecom/AWS-EKS.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "aws-eks-cluster-state"
  # }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

# data "aws_eks_cluster_auth" "cluster" {
#   name = aws_eks_cluster.eks-Cluster.id
# }

# Terraform Kubernetes Provider
provider "kubernetes" {
  host                   = aws_eks_cluster.eks-Cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks-Cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# provider "github" {
#   token = var.github_token
# }







