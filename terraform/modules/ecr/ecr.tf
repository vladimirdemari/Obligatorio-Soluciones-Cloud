# Crea un repositorio en Elastic Container Registry (ECR)
resource "aws_ecr_repository" "app_repository" {
  # Nombre del repositorio, definido mediante una variable
  name = var.ecr_repository_name

  # Configuración para escanear automáticamente las imágenes en busca de vulnerabilidades
  image_scanning_configuration {
    # Habilita o deshabilita el escaneo automático al momento de subir las imágenes
    scan_on_push = var.ecr_scan_on_push
  }

  # Define si las etiquetas de las imágenes pueden modificarse o no
  image_tag_mutability = var.ecr_tag_mutability

  # Etiquetas asociadas al repositorio para identificar su entorno y equipo responsable
#  tags = {
#    Environment = var.environment  # Entorno del recurso (por ejemplo: Staging, Production)
#    Team        = var.team         # Equipo encargado de este recurso
#  }
}

# Define una política de ciclo de vida para administrar las imágenes dentro del repositorio
resource "aws_ecr_lifecycle_policy" "app_lifecycle_policy" {
  # Vincula la política al repositorio creado anteriormente
  repository = aws_ecr_repository.app_repository.name

  # Especifica las reglas de la política usando JSON
  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Eliminar imágenes no usadas después de 30 días",
        "selection": = {
          "tagStatus": "untagged",
          "countType": "imageCountMoreThan",  
          "countNumber": 5
        },
        "action": {
          "type": = "expire"  # Marca las imágenes seleccionadas para ser eliminadas
        }
      }
    ]
  })
}

  # Etiquetas para organizar el recurso y asociarlo con su entorno y equipo
#  tags = {
#    Environment = var.environment  # Entorno del recurso (Staging, Production, etc.)
#    Team        = var.team         # Equipo responsable del recurso
#  }

