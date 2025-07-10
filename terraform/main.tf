terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "python_app" {
  name         = "python-terraform-app"
  build {
    context    = "${path.module}/../"
    dockerfile = "docker/Dockerfile"
  }
}

resource "docker_container" "python_app" {
  name  = "python_app_container"
  image = docker_image.python_app.name
  ports {
    internal = 5000
    external = 5000
  }
}
