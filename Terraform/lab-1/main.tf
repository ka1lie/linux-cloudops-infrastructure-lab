resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

resource "docker_image" "whoami_image" {
  name = "traefik/whoami:latest"
}

resource "docker_network" "create_network" {
  name = "${var.environment}_network"
}

resource "docker_container" "nginx_container" {
  name  = "nginx_${var.environment}"
  image = docker_image.nginx_image.image_id
  ports {
    internal = 80
    external = var.port
  }
  networks_advanced {
    name = docker_network.create_network.name
  }
  volumes {
    container_path = "/etc/nginx/conf.d/default.conf"
    host_path = abspath(local_file.defaults_config.filename)
  }
  depends_on = [local_file.defaults_config]
}

resource "docker_container" "whoami_container" {
  name  = "whoami_${var.environment}"
  image = docker_image.whoami_image.image_id
  networks_advanced {
    name = docker_network.create_network.name
  }
}

resource "local_file" "defaults_config" {
  filename = "${path.module}/defaults.conf"
  content  = templatefile("${path.module}/defaults.conf.tftpl", {
    container_name = docker_container.whoami_container.name
  })
  directory_permission = "0755"
  file_permission = "0644"
}