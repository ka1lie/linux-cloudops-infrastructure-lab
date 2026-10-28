data "aws_ami" "amazon_linux_image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_network_interface" "get_ip" {
  subnet_id   = var.subnet_public_id
  security_groups = [var.sg_id]

  tags = {
    Name = "primary_network_interface-${var.environment}"
  }
}

resource "aws_instance" "create_ec2_server" {
  ami = data.aws_ami.amazon_linux_image.id
  instance_type = var.server_type
  region = var.aws_region
  primary_network_interface {
    network_interface_id = aws_network_interface.get_ip.id
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 12
    encrypted = "true"
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
  tags = {
    Name = "server-${var.environment}"
  }
}

resource "aws_eip" "attach_public_ip" {
  domain = "vpc"
  instance = aws_instance.create_ec2_server.id
  associate_with_private_ip = tolist(aws_network_interface.get_ip.private_ips)[0]

  depends_on = [var.igw_id]
}