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

 
