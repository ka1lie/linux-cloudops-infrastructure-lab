## Goals

1. Create a new container with Terraform
2. Delete a new container from console and restore by Terraform
3. Create a new volume from console, import to Terraform and manage as a Terraform resource
4. Move Terraform volume resource to another without deleting physical volume
5. Create test api with sensitive data and look to tfstate file to ensure behaviour

## Installation

Install as a mentioned earlier in lab-1 https://github.com/ka1lie/linux-cloudops-infrastructure-lab/blob/main/Terraform/lab-1/README.md

## Checks

After we add a new container in Terraform main.tf, we need to use terraform apply again to deploy a new one

After successful deployment, check sudo terraform plan and it display:

```bash
No changes. Your infrastructure matches the configuration.
Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```
Now we need to delete our new container manually and run terraform apply again to re-create a container

```bash
sudo docker stop lab2-test-container
lab2-test-container
sudo docker rm lab2-test-container
lab2-test-container

sudo docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS              PORTS                  NAMES
58d658ef9062   4c41e2d0a3a5   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp   nginx_dev
ac95a8832b12   c4717a8d1f01   "/whoami"                About a minute ago   Up About a minute   80/tcp                 whoami_dev
```

Now we should create a new volume and import this volume for Terraform control

```bash
sudo docker volume create lab2-legacy-data
```

Add these block to main.tf

```bash
import {
  to = docker_volume.test_volume
  identity = {
    name = "lab2-legacy-data"
  }
}

resource "docker_volume" "test_volume" {}
```

Execute terraform apply and our volume will be managed by Terraform without deletion

Now we want to move our docker_volume resource to another. We need to comment import block and old resource, create a new empty resource and create moved block

Next we created a new resource with test api and disallow visible through console. Execute terraform allpy, our value doesn't apeear and show as a sensitive data, but if we watch to a tfstate file we can see our value

## Q&A

Q: What's the difference between terraform plan and with flag -refresh-only? Why using terraform plan -refresh=false can lead to uncosistent state?

A: If we use refresh-only flag we only looked at changes outside of our Terraform scripts looking at a real infrastructure and show us what will be synced. If we use -resfresh=false we skipping Terraform state sync with real infra which leat us to an uncomplete plan

Q: Why flag sensitive = true does not lead us to a secure storage in tfstate file?

A: It helps to prevent leak sensitive data directly from console or store as a plain text in some logs. We should use ephemeral = true to use some sensitive data only once at a Terraform run without storing in a tfstate file
