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
  tags = {
    Environment = var.environment  # Entorno del recurso (por ejemplo: Staging, Production)
    Team        = var.team         # Equipo encargado de este recurso
  }
}

# Define una política de ciclo de vida para administrar las imágenes dentro del repositorio
resource "aws_ecr_lifecycle_policy" "app_lifecycle_policy" {
  # Vincula la política al repositorio creado anteriormente
  repository = aws_ecr_repository.app_repository.name

  # Especifica las reglas de la política usando JSON
  policy = jsonencode({
    rules = [
      {
        # Prioridad de la regla (1 indica la regla más importante)
        rulePriority = 1

        # Descripción de la regla, para referencia en el futuro
        description  = "Eliminar imágenes no usadas después de 30 días"

        # Selección de imágenes no etiquetadas para ser gestionadas por la política
        selection = {
          tagStatus = "untagged"          # Aplica solo a imágenes sin etiqueta
          countType = "imageCountMoreThan" # Considera el número de imágenes
          count     = 5                   # Solo mantiene las últimas 5 imágenes
        }

        # Acción a realizar: eliminar (expire) las imágenes que cumplan con los criterios
        action = {
          type = "expire"  # Marca las imágenes seleccionadas para ser eliminadas
        }
      }
    ]
  })
}
# Crea un parámetro en AWS SSM Parameter Store para almacenar información adicional
resource "aws_ssm_parameter" "app_namespace" {
  # Nombre del parámetro en el SSM, definido mediante una variable
  name = var.namespace_parameter_name

  # Tipo del parámetro, en este caso es una cadena de texto
  type = "String"

  # Valor asociado al parámetro, definido también mediante una variable
  value = var.namespace_value

  # Etiquetas para organizar el recurso y asociarlo con su entorno y equipo
  tags = {
    Environment = var.environment  # Entorno del recurso (Staging, Production, etc.)
    Team        = var.team         # Equipo responsable del recurso
  }
}
