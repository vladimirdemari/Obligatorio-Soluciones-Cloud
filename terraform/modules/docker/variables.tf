variable "applications" {
  description = "Lista de aplicaciones"
  type        = list(string)
}

variable "registry_url" {
  description = "URL del repositorio de Elastic Container Registry (ECR)"
  type        = string
}

variable "commit_short_sha" {
  description = "Identificador sha corto del commit actual"
  type        = string
}

variable "docker_url" {
  description = "The Docker registry address"
  type        = string
}
