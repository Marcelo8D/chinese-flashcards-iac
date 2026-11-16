terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
  cloud {
    organization = "dvader-org"
    workspaces {
      name = "chinese-app-iac"
    }
  }
}

provider "cloudflare" {}