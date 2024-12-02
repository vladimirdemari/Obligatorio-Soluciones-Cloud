output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.oisc.id
}

output "public_subnets" {
  description = "IDs de las subnets públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "IDs de las subnets privadas"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways creados"
  value       = aws_nat_gateway.nat[*].id
}
