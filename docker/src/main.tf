terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
  depends_on = [docker_image.nginx]
}

resource "time_sleep" "wait_3_seconds" {
  create_duration = "3s"
  depends_on = [docker_container.nginx]
}

resource "null_resource" "check_webserver" {
  provisioner "local-exec" {
    command = "sleep 1; curl -v http://localhost:8000"
  }
  depends_on = [time_sleep.wait_3_seconds]
}
