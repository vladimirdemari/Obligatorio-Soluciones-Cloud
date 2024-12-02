# Grupo de seguridad para la instancia
resource "aws_security_group" "bastion_sg" {
  name          = "bastion-sg"
  description   = "Permitir SSH y trafico HTTP/HTTPS"
  vpc_id        = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permitir SSH desde cualquier lugar
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Permitir trafico saliente
  }
}

