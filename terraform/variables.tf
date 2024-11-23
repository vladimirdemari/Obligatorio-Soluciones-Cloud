variable "aws_region" {
  description = "Región de AWS"
  default     = "us-east-1"
}

variable "environment_name" {
  description = "Nombre del entorno (dev, staging, prod)"
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR para la VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDRs para subnets públicas"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs para subnets privadas"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}