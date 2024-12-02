# Salidas utiles
output "bastion_sg_id" {
  description = "sg asociado a la instancia"
  value       = aws_security_group.bastion_sg.id
}

