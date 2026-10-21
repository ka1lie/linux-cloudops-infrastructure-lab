## Goals

1. Deploy proxy server and test application via Docker
2. Create networks and attach them to containers
3. User can set dev or stage environment, and port for proxy server or use default 8080
4. No publish port
5. Dinamically change nginx configuration based on environment

## Installation

Clone this repository to your local machine

```bash
git clone https://github.com/ka1lie/linux-cloudops-infrastructure-lab
cd linux-cloudops-infrastructure-lab
```
Initialize Terraform

```bash
terraform init
```

Terraform will automatically installed all dependences 

## Deploy

You can check what Terraform will do by using

```bash
sudo terraform plan -var="port=8081"
```

If you want to use your port, you should use the -var flag, or it will be start nginx by default 8080 port

To deploy services you should use

```bash
sudo terraform apply
```

Now you need to choose your environment - it can be stage or dev. If you leave empty response or something else, the Terrafrom stops running.

## Check

After successfull installation, you can run on your local machine and you see responce from your test application

```bash
curl http://127.0.0.1:{your_port}

Hostname: 75ceea24ab96
IP: 127.0.0.1
IP: ::1
IP: 172.18.0.2
RemoteAddr: 172.18.0.3:40870
GET / HTTP/1.1
Host: whoami
User-Agent: curl/8.12.1
Accept: */*
```

Now you can change port or environment and Terraform rebulid containers to matching configuration

To destroy, use sudo terraform destroy
