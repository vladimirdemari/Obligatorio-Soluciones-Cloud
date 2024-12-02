terraform {
  backend "s3" {}
}

# Crea un repositorio en Elastic Container Registry (ECR)
resource "aws_ecr_repository" "app_repository" {

  for_each = toset(var.applications)

  # Nombre del repositorio, definido mediante una variable
  name = each.value

  # Configuración para escanear automáticamente las imágenes en busca de vulnerabilidades
  image_scanning_configuration {

    # Habilita o deshabilita el escaneo automático al momento de subir las imágenes
    scan_on_push = var.ecr_scan_on_push
  }

  # Define si las etiquetas de las imágenes pueden modificarse o no
  image_tag_mutability = var.ecr_tag_mutability

}

# Define una política de ciclo de vida para administrar las imágenes dentro del repositorio
resource "aws_ecr_lifecycle_policy" "app_lifecycle_policy" {

  for_each = aws_ecr_repository.app_repository

  # Vincula la política al repositorio creado anteriormente
  repository = each.value.name

  # Especifica las reglas de la política usando JSON
  policy = <<EOF
{
    "rules": [
      {
        "rulePriority": 1,
        "description": "Eliminar imágenes no usadas después de 30 días",
        "selection": {
          "tagStatus": "untagged",
          "countType": "imageCountMoreThan",  
          "countNumber": 5
        },
        "action": {
          "type": "expire" 
        }
      }
    ]
}
EOF
}

