# Salidas utiles
output "bastion_sg" {
  description = "sg asociado a la instancia"
  value       = aws_security_group.bastion_sg.id
}

output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.bastion.id
}


