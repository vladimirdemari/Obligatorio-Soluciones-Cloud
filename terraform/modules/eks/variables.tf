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

variable "cluster_name" {
  description = "Nombre del clúster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versión de Kubernetes"
  type        = string
  default     = "1.31"
}

variable "role_arn" {
  description = "ARN del rol IAM asociado a los nodos"
  type        = string
}

variable "authentication_mode" {
  description = "Modo de autenticación del clúster EKS (API o ConfigMap)"
  type        = string
  default     = "API"
}

variable "cluster_endpoint_public_access" {
  description = "Habilitar acceso público al endpoint del clúster"
  type        = bool
  default     = false
}

variable "cluster_endpoint_private_access" {
  description = "Habilitar acceso privado al endpoint del clúster"
  type        = bool
  default     = true
}
variable "support_type" {
  description = "Política de actualización del clúster"
  type        = string
  default     = "STANDARD"
}


variable "eks_managed_node_group_defaults" {
  description = "Configuración predeterminada para los grupos de nodos manejados"
  type = object({
    instance_types = list(string)
  })
  default = {
    instance_types = ["t3.medium"]
  }
}

variable "eks_managed_node_groups" {
  description = "Configuración de grupos de nodos manejados"
  type = map(object({
    desired_capacity = number
    min_size         = number
    max_size         = number
    ami_type         = string
    additional_tags  = optional(map(string))
  }))
  default = {}
}

variable "update_max_unavailable" {
  description = "Número máximo de nodos no disponibles durante las actualizaciones del grupo de nodos"
  type        = number
  default     = 1
}

variable "node_role_arn" {
  description = "ARN del rol IAM asociado a los nodos"
  type        = string
}

variable "bastion_sg_id" {
  description = "ID del Security Group asociado al bastion"
  type        = list(string)
}

