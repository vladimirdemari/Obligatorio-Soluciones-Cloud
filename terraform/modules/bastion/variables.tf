variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "desired_capacity" {
  description = "Número deseado de instancias en el ASG"
  type        = number
}

variable "max_size" {
  description = "Número máximo de instancias en el ASG"
  type        = number
}

variable "min_size" {
  description = "Número mínimo de instancias en el ASG"
  type        = number
}

variable "public_subnets" {
  description = "IDs de las subnets públicas"
  type        = list(string)
}

