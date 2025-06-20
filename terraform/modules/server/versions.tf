terraform {
  required_version = ">= 1.6.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.50.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.2"
    }

    external = {
      source  = "hashicorp/external"
      version = ">= 2.3.5"
    }

    null = {
      source = "hashicorp/null"
      version = ">= 3.2.4"
    }
  }
}
