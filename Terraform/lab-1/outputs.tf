output whoami_ip {
  description = "IP address for app"
  value = docker_container.whoami_container.network_data
}