resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

resource "docker_image" "whoami_image" {
  name = "traefik/whoami:latest"
}

resource "docker_network" "develop_network" {
  name = "dev_network"
}

resource "docker_network" "stages_network" {
  name = "stage_network"
}

resource "docker_container" "nginx_container" {
  name  = var.environment == "dev" ? "nginx_dev" : "nginx_stage"
  image = docker_image.nginx_image.image_id
  ports {
    internal = 80
    external = var.port
  }
  networks_advanced {
    name = var.environment == "dev" ? "dev_network" : "stage_network"
  }
}

resource "docker_container" "whoami_container" {
  name  = var.environment == "dev" ? "whoami_dev" : "whoami_stage"
  image = docker_image.whoami_image.image_id
  networks_advanced {
    name = var.environment == "dev" ? "dev_network" : "stage_network"
  }
}