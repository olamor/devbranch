terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "prom" {
  name         = "prom/prometheus:latest"
  keep_locally = false
}



resource "docker_image" "graf" {
  name         = "grafana/grafana:latest"
  keep_locally = false
}



resource "docker_container" "prom" {
  image = docker_image.prom.latest
  name  = "prometheus"
  ports {
    internal = 9090
    external = 9090
  }
}

resource "docker_container" "graf" {
  image = docker_image.graf.latest
  name  = "grafana"
  ports {
    internal = 3000
    external = 3000
  }
}
