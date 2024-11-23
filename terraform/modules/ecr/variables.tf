

variable "ecr_repository_name" {
  description = "Nombre del repositorio de Elastic Container Registry (ECR)"
  type        = string
  default     = "custom-repository-name"
}

variable "ecr_scan_on_push" {
  description = "Habilita o deshabilita el escaneo automático de imágenes en ECR"
  type        = bool
  default     = true
}

variable "ecr_tag_mutability" {
  description = "Define si las etiquetas de imágenes son mutables (MUTABLE) o no (IMMUTABLE)"
  type        = string
  default     = "MUTABLE"
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

variable "namespace_parameter_name" {
  description = "Nombre del parámetro en SSM para el namespace de la aplicación"
  type        = string
  default     = "/namespaces/online-boutique"
}

variable "namespace_value" {
  description = "Valor asociado al parámetro del namespace en SSM"
  type        = string
  default     = "staging"
}

