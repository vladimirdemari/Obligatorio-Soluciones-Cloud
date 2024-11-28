variable "ecr_repositories_names" {
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

variable "environment" {
  description = "Define el entorno asociado a los recursos (Development, Production, etc.)"
  type        = string
  default     = "Staging"
}

variable "team" {
  description = "Equipo responsable de los recursos"
  type        = string
  default     = "BackendTeam"
}


