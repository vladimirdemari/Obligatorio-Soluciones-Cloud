resource "aws_launch_template" "bastion" {
  name          = "bastion-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "vockey"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.bastion_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              # Actualiza los repositorios e instala paquetes necesarios
              apt-get update -y && apt-get upgrade -y
              apt-get install -y vim git unzip curl gnupg software-properties-common apt-transport-https ca-certificates

              # Instalar AWS CLI
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              ./aws/install
              echo "complete -C '/usr/local/bin/aws_completer' aws" >> /home/ubuntu/.bashrc

              # Instalar Terraform
              curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
              echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
              apt-get update -y && apt-get install -y terraform
              echo "complete -C /usr/bin/terraform terraform" >> /home/ubuntu/.bashrc

              # Instalar kubectl
              mkdir -p /etc/apt/keyrings
              curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
              chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
              echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" > /etc/apt/sources.list.d/kubernetes.list
              chmod 644 /etc/apt/sources.list.d/kubernetes.list
              apt-get update -y && apt-get install -y kubectl bash-completion
              echo 'source <(kubectl completion bash)' >> /home/ubuntu/.bashrc
              EOF
  )
}

