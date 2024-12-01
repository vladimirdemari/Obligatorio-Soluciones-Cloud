# Proveedor de AWS
provider "aws" {
  region = "us-east-1" # Cambia a tu región preferida
}

# Obtener la última AMI de Ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # ID del propietario oficial de Ubuntu
}

# Instancia EC2
resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro" # Cambia según lo necesites

  security_groups = [aws_security_group.bastion_sg.name]

  tags = {
    Name = "bastion"
  }

  # Configuración opcional: instalar Apache en el inicio
  user_data = <<-EOF
              #!/bin/bash
	      # Actualiza los repositorios e instala paquetes necesarios
              apt update -y && sudo apt upgrade -y
	      # Instala vim, git, y curl
	      sudo apt install -y vim git cur
	      # Instala AWS CLI
	      curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	      unzip awscliv2.zip
	      sudo ./aws/install
	      # Instala Terraform
	      sudo apt install -y gnupg software-properties-common
	      curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	      echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
	      sudo apt update -y
	      sudo apt install -y terraform
              
              EOF
}

# Elastic IP
resource "aws_eip" "elastica_bastion" {
  instance = aws_instance.bastion.id
  domain   = "vpc"
}



