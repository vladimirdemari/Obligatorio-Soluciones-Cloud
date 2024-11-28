variable "aws_region" {
  description = "Región de AWS"
}

variable "environment_name" {
  description = "Nombre del entorno (dev, staging, prod)"
}

variable "vpc_cidr" {
  description = "CIDR para la VPC"
}

variable "public_subnet_cidrs" {
  description = "CIDRs para subnets públicas"
}

variable "private_subnet_cidrs" {
  description = "CIDRs para subnets privadas"
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad"
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

variable "applications" {
  description = "Componentes del proyecto"
  type        = list(string)
}

variable "commit_short_sha" {
  description = "Identificador sha corto del commit actual"
  type        = string
}

variable "docker_url" {
  description = "The Docker registry address"
  type        = string
}
