output "cluster_id" {
  description = "ID del clúster EKS"
  value       = aws_eks_cluster.this.id
}

output "cluster_endpoint" {
  description = "Endpoint del clúster EKS"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate" {
  description = "Certificado del clúster EKS"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "node_group_names" {
  description = "Nombres de los grupos de nodos manejados"
  value       = keys(aws_eks_node_group.managed)
}

