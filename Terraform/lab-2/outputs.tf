output whoami_ip {
  description = "IP address for app"
  value = docker_container.whoami_container.network_data
}

output whoami_container_name {
  description = "Name of the whoami container"
  value = docker_container.whoami_container.name
}

output api_token {
  description = "Test api tolen output"
  value = terraform_data.api_token
  sensitive = true
}