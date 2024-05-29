terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.54.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 3.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "kubeconfig"
  }
}

provider "exoscale" {
  key = var.exo_api_key
  secret = var.exo_secret_key
}
provider "cloudflare" {
  email = var.cloudflare_email
  api_key = var.cloudflare_api_key
}