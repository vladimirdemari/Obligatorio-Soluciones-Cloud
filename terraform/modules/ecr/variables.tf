variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "applications" {
  description = "Nombres de repositorios para Elastic Container Registry (ECR)"
  type        = list(string)
}

variable "ecr_scan_on_push" {
  description = "Habilita o deshabilita el escaneo automático de imágenes en ECR"
  type        = bool
  default     = true
}

variable "ecr_tag_mutability" {
  description = "Define si las etiquetas de imágenes son mutables (MUTABLE) o no (IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"
}

variable "environment_name" {
  description = "Nombre del entorno (dev, staging, prod)"
  type        = string
}

