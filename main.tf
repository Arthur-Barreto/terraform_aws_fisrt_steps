terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "ssh_key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_security_group" "sec" {
  name        = "sec"
  description = "Allow SSH inbound traffic"
  
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0e783882a19958fff"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer_key.key_name
  security_groups = [aws_security_group.sec.name]

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

# Output the private key to a file
resource "null_resource" "save_private_key" {
  triggers = {
    key_name = aws_key_pair.deployer_key.key_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo '${tls_private_key.ssh_key.private_key_pem}' > ssh_key.pem
      chmod 400 ssh_key.pem
    EOT
  }
}

output "private_key_file" {
  value = "ssh_key.pem"
}