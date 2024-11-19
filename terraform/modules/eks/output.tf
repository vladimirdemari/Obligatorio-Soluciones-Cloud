output "cluster_name" {
  description = "Nombre del clúster EKS"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint del clúster EKS"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "ID del Security Group del clúster"
  value       = module.eks.cluster_security_group_id
}

