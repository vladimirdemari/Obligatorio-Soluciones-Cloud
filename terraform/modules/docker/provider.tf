terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"

  registry_auth {
    address     = var.registry_url
    config_file = pathexpand("~/.docker/config.json")
  }
}

