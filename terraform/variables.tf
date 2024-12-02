variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "environment_name" {
  description = "Nombre del entorno (dev, staging, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR para la VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDRs para subnets públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs para subnets privadas"
  type        = list(string)
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
}

# Configuracion de EKS
variable "cluster_name" {
  description = "Nombre del clúster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versión del clúster EKS"
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

variable "applications" {
  description = "Componentes del proyecto"
  type        = list(string)
}

variable "commit_short_sha" {
  description = "Identificador sha corto del commit actual"
  type        = string
}

variable "registry_url" {
  description = "The Docker registry address"
  type        = string
}

