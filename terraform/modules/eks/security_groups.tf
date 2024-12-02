resource "aws_security_group" "cluster" {
  name          = "${var.cluster_name}-cluster-sg"
  description   = "Security group for EKS control plane"
  vpc_id        = var.vpc_id

  ingress {
    description = "Permitir la comunicacion de los componentes dentro del cluster"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Permitir el acceso a la API de Kubernetes desde el Bastion"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = var.bastion_sg_id
  }

  egress {
    description = "Permitir salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

