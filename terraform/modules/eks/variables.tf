variable "cluster_name" {
  description = "Nombre del clúster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versión de Kubernetes"
  type        = string
  default     = "1.31"
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "private_subnets" {
  description = "IDs de las subnets privadas"
  type        = list(string)
}

variable "public_subnets" {
  description = "IDs de las subnets públicas"
  type        = list(string)
}

#variable "control_plane_subnet_ids" {
#  description = "IDs de las subnets para el plano de control"
#  type        = list(string)
#}

#variable "tags" {
#  description = "Etiquetas aplicadas a los recursos"
#  type        = map(string)
#}

